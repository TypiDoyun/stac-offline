import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:offline/Widgets/mainlistitem.dart';
import 'package:offline/Widgets/user-main-shop-list-item.dart';
import 'package:offline/classes/clothes.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:offline/userpages/userselectedclothes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ownerpages/shopinfopage.dart';
import '../utils/common/try-get-clothes-info.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({
    super.key,
  });

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  dynamic clothesInfo = [
    {"images": "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"},
    {
      "images":
          "data:image/jpeg;base64,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"
    },
    {
      "images":
          "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBQVEhgREhIYGBIYGhgZGBgYGBgaGRgYGRoZGRkYGhgcIS4lHB4rIRgYJjgnKy8xNTU1GiQ7QDs0Py40NTQBDAwMEA8QGhISGjQlISExMTE0NDQ0NDQ0PTQxNDQxNDQ0NDQ0MTE1NDQ0NDQ0NDE0NDE0NDE0NDQxNDE0NDQ0Mf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAAAQIEBQYDBwj/xABMEAACAQIDBAYFCAYGCQUAAAABAgADEQQSIQUxQVEGEyJhcYEyUpGhwQcUQmKSorHRI1OCk7LwFjNy0uHxFSQ1Q1Rjc7PCFyVk0+L/xAAYAQEBAQEBAAAAAAAAAAAAAAAAAQIDBP/EACMRAQEAAgICAgEFAAAAAAAAAAABAhEhMQNBElEyImFxgZH/2gAMAwEAAhEDEQA/APULwvEhIFi3jbwvKHRY28WELCJFgEIRICxISv23tilhaLV6zWQct5J0AA4mBPJiTynFfKvUzXp4ZOr5OzZj5qbD2TGY/pNi65D1K75gTbKxQLx7OX0RIun0RCeI9H/lBxdFwK1Rq9IaMr2Z7c1c9q/iSJ7LgcYlamtak4em4urDiPgQbgjgQYWxIiGBiGEJC8IhMAvGkxpMQtAdeF4wtEzQjy/pZtFjjapQlLEUzYkZ8qBGzW3g2tblLPopRSk74qsAqrTpdUzkIpbEC62LccoAzcAx77N6VdHXbGLUp3KYhwptvR8t236WKqzA8wQbaXhdKK+IpVkC5VpZbUEFnTIjFFUqyjMbZTuOjixF7Dh1blWNc7r0rDJlGbNmZrFmH0uVvq8hy5kknO7QTEDEI1athXpipnSi6lHAUN2qZ1JcLc3Nxdb6cK3YPSCoK706lPJSFZKQVAclEMXUDkDnRfHM/BRbOV8PUxGMZGBNV6hDA71s1jcjcqgeQE1lnNTTVraf09wP6x/3TwkX/wBP8N+tq/c/KEbzTlu4QhOzYhCEAvHRsIQ6LGwaA6EaL8YsBZ4v8qe22rYs4Rf6ugQLetUK3ZvINlHg3Oezzwv5StnMm1HspIr5HTvzKqML88yt5ESVrHtkst4mU+yW77FqIQLoGJtkZ1BPKxJA58RLvAdDWqpVd6ioqC6kXbtcQRy85j5x0mFrGhDfMPOemfJRtNxWfCXJpMhqqD9B1KqcvcwOv9kd8otm9EWrC6YinnuVKkNYlbXysBYmxBI4Xl98muyGp7QxJqGz0EFMga3NVrgg8rUz9oTUsrOWNkenwMCY0mVgXjSYExpMBGMYWgxnNjAHc2JAubGwva54C/CZJ8bi8Oj1cZiUUurLTpKiuc9r3GUAADxYai53TV3mX6abKbEIhpm9WmHbJxdCFzBR611Fueomcp7Zrh0T6Q1qrulcBmWmzo+UDVLZk0AW/aB0AOmt9Ldtv4OuT1lTE06GDoFGp2TrHuqhQdR6RNwACeGlxKboAzBcUuuQKoI1sHs+ludr38pa9P6btRR11pozFwOBIARz3Dtj9qY3fjunpGfpPSWmzLTX9HilZyg7NYN1p62/BjkLa7iE1tpNdSdCr1qSr1joHvYBmul6eYb+UwGz9nYdaaUcVVKVKxR3pns2ppnZVdyCEzXR7GxstuMeNqVUxlfE0LdW+VFDnTKgQIbfRHZNhyfnJ8tTdJVT/pOr/wARV+235wjvmv1V/eN+UJz+X7o9siQiGepssIkIDoRIsoIsSEBYsaIsIWYTpxgs+Lw7vqoC9X9V1cmp4XVk8SBym6kPamzkroFYlSpzKw3qd27iDymc5bOG8LJlywo2cjEvYZhxsLydsJ6QzozKB2AQSN7myDxNxImMR0d0vZgSO4kfCc9jPiDUsaaWvp2jbxvbWeWd8vdjPlOGp2fh1Fwoso1t8REwGFCYh2VbF3NR2tvBppTC342KA/teMl4YMAS+W/1b2ty13+MlJTC8NTvnTCbrj5LJDzGkwJjSZ3eUExhMVjOTGAMZyZormcHaAzGYjJTd7XyIz255VJt7p5OmIrVcSj9bbEM4yOxsA9+wAdcovZQN2oG6esMQdCLg6EHiOU8w29ss4bFpTpvYMUdHbQJ2yO0TvykAk+Gk5Zb4ZrZfOK7tWzUurqJTRgLaVDkbPdge2ASVAv2cwJubTP4bpHWDpVao7hsy1aZ9AkaArfRDYgkDip4Gwr+jm16lPGVPnDPZ84rK2pDrfUgbmBGXTTW27dF2rjM7OwBzMznjvJ3954eUmV61TbrtDFM9ZqykB3ZmLXzFBwCniQAB5CPrbQCqXBLFiS1ybk8BfeTx15mM2li0qCkadPJUFJBUcaB3CAMAvAA6X3+wSLiUNgwcaBHJ4AsoJHZvuJt5bpzs5RL+fN6n33/uwkPNX/W/z7IS6n0096hGwnpUQhCA68WMi3lDot4y8Lwh8Il4sKITniKuRGexOUFrDebC+k8y2j01xThlpuqAnQoFDW9UO4YDxtfvEC66X3XE3H0kUn7y/wDiIuwanHLf4TG7DxTOv6QuXLEt1jl3v6OrHXhNXsUFagF9N5nly/KvZhP0xqaj2GZ7BRrbw5zJ9EekjjDU1r5nBGjk3YC1xe+rDQ8byX0w2jlomkh7b9gd195maqladNaScAF8rD/CdvFO3Hy+nqCuGAZSCpFwRuI5xpMw+y9sPRW5N6f0lY6a8VPA/jNbhdoU6qhqbqSQDluMwuL2K7wROlmnF3YxjGK05uZAx2nF2nRpweA1mlR0m2acRhmRApqKQyZrbwRmUE7iRcct1+YtHMjYx2FN+r/rMrZP7VtPOZqPLaNRzUyvcOSKWZ79lg2Wznfpex3kWGmk64gmxHZ5HLrbcd5114cxcc5JfCu6mqVLBHOe57ZNiSbHU6m5J5+MhopJLnfcnz0tp5zhayfh0ZiFNspNuF93Pjx0kjE2IbIvZABHK+gFxyuSd+sjdYU1338uW7lxilEyIVLZiXNiBltoFKkG5OhBv3yCf87T1F9/5xZWZfGED3yBiQnqbEIl4l4DoXjbxLwH3i3jAYt5Q8GKDOTuFBZiAoFySbAAcSZjtsdMzcphgOWdhr4qvDz9ggWfTnbC4fDFCTmq3QEH0V+kT4jTznlXWKfRIt3SfjKzVGL1GLsd5Y3J9v4SC2DQ/RmtB9CplYE+0cp6FsnBK9NX63tZQ1sqhsrbj6Z00OvMEcDPN2wtvRY/aPxuJdpnGGwrJUKshrIWBsRlqBxYgcqpmLjLeY3Msp1VjtvJ1rlDmajTzm/aJY1ETLwAC5wSQOFuEraAAbNUu9QjMEGlgfpM25R7zynTZ1Nji7C16iVKdzc6ujZASfrhD5c9Z1oLcAu1xppYAd1wNT5zeM1wzbbzXGpmJDub30UDRQOYHfzOsUNaPxJzNEC6iVFrs3bFRGALFk3ZW19nKaunWDqGXcfceRnn9U2YdxH4zRbJxWRkRjo/Z/aXRT52t7JMoL4zg87mcXnIcGkbFVwiM7WsoJ10B5DzNh5yWwlP0nps2DqhBc5QSPqhlLfdBPlJeJsZB8S5qtUSoSrjfYWfNYO2VtMpdTv4ADcLSdtrBU6CtUCgF+zkubA3DZgd/Ddu1HLWrwWznqWSnq6DNYmwyg3Ivzu3HnOe2nqPWZqyMrNqqt9FLnKLeR984b4YRXrkr2dLajcbHTX+eUktRDqagawe5YrYZagsXXLcdnUkW0sQJ0wpUreoAcxABt6KhVUEWHAWIA35ZWICwKlm1OveBuGu72SS9idp67fahEzUvWf7KfnCT+x7tGkwiEz2Ni8S8Il4C3heEIADFiQEox3T7a+TJhg1gVNR/DMEQeF85/ZWYthr3GSemOJ6zH1b+iP0Y8EAU/eDHzkLCVM1MA+kuh8v5v5zUHUHtZTGsNYmK0s0azXsYHREuZZ4YWwtv/kVLeHV0L++V+CN3tLfDYZ2wzhRotcm5Pr0xfy/Rj2+Ngh0cRkqpU9R0fyVgT+Em4mlkqOnquy/ZYgfhIWIwptq6C+h7aEi5tewOvPThLbaIzOtQMGDojAg7yFCMbcs6P7InYr2WCDWPaJR1M0jnUHaHjJO2K2QJbfmv7zOdVe1Ie26uasicgv4A/GSj0DCV89NX4ka+PGOcSq2BW06s8RceI3+78JbsJzymqriRGVdFZiLgAm3Owvad7So6TY7qqDKL53DItuGlma/MA6d9pnKyTdKx2wq9ZKn6GmruQFbNcAJcFiWHobhqb8NDunHpDVFbFva4VOwb80uGt3XLbxwljg8YmGrIxTs9SzMeLswzqBc2ABUKNOJJvpKjaNdKpOJChWapaoovlzOoYZb6/RfMeJFxa9p5/Wts+jsa9P5q7dYOueomVL9oIvpFbbr31J35fGU9GswVrbzbUi/HnwnWugBsw04HuPH3zg3YGbLdCbXtppY2sd+/dE60ib1lH9U32//AMQkb5yPXHsT8oS6NvoGEIk9LYjYQgEIkWARwPE7uMbIm2KxTDVXG8U3t42t8ZR4/tRy7GtxLsx/aJPxkfDVbP3N+I/n3SahU3VvRP8AO+VOPptTIJ1W91bge680LvELdZDVpLR81MHmJX1jYxRP2RrU9ss8MwPX0+NqdUfsVOrPure6V+xF7RPISZsxr4l19eliF+zTaoPvU1j0OVbfJ+z3zYcqfSo1NBb/AHdYEj2Oj/vBK7EHtSw2Ot3qL61Bz5o9J/4Uf2yhKmgi4BbtGYprC0k7KTjCGYtbPIdXCM+MZvohUN+7It/fJuNP6Scdu4sU0HrMg/FhAl7KxQatkX6GvefPcPD3zY2mB6IUzZ6zcpusDUz01but7NPhM5faulpUbewxq5KSKDUIqMGIvlCpw4XZ2RddwJI1sZdZYzq+1m5LYd1zdvbZfsznZuaGIw2Dp10w9Fgevam97blo53AaoTuYWsANeBtoRRYmjRfrjRqelVR1Qg3KfpgbaWuC6sBfRTzJA0uJ2ilDHV6hS7nKir6ICZFd3JtvJAPme6YwFQwYDsE634dx5cp58rJwwKiL2OsOgIzFddLi9tN9pPw+JwzU3wz03WiawqI6srVPVCkFQB2eOu875EbD52tmAUhgp19OxyA6biwUeZ3SLhh2+1dQttbajnpxNvwkxuoWmfNj+pX7Z/OEm9ZR/X1f3Cf/AGwmt029xjY6NnpbESEIBCEIBK7pE1sHXP8Ayz77D4yylL0xfLgaveEHtqJKPNaI7UdiR2GAAvY6cG7mG4+cbg3GZb8RaMxwYXmhG2TXzU7brXFuVjunPEtrI+zXszDvv7f8o6u13t3yC92SLU2bu+EldHhfGUjzZx9qm6/GREbLStxMkbLOSolS9irBrjUi1/x3ect6Eau2oMttiOBVpsfRL5G/sVQabX8M9/KVFcSfg0zU2ANjY2PI8DKDHXDZG9IGxHeNCPbLPZiWWVmOrGpWaobXc5yBuDOAzDyJI8pd4ZbU4gqsSb1POVHS2mz4ijTG40wT+8cS3qa1POO2oqjEU2O/qwPvv+cVErC0xSw2UbyJd9Fq2eiR6rfj/lM3i6vZ7pa9BqtzUTuDew2+MmXStVaFo/LFyzA8y6XBlxpbOVYldbXCKAmRh7yR9XvlTQZWZ2RAlNmJVAxbKt9AzHfyF/zv6VtXYKVqoqvwR0YeKsoYDcSMwIv6omF6JYF8RemW/RpZiL2ID3DsmhudE7rgTy54X/WdKxzYZrDQ3FxoSCdSOPHSbXaeAwmIyvUplHrAMlRLLbsI13sbEkOBqDu3iVuI6Mt85FBagKZc5b6QTMFIKjcbnQ6A2PhOmHwtZ0p4VnV1VmCsim5o6WqZy2UqRYAaWIsSdJcJcZdxOYmf0Fwv/M+3/hCaXO36tftn+7CdNT6aWhiQhOqkhFMSAQhCATPdO2tgmHN0HvJ+E0UzHygN/qijnVQfcqH4Sweb03tbuMmYoZlzDfaQdxk6m3ZmoM5RqZa1jxuPPfJNM5qoHfE2ggFRW7/gTDZq3cvw3CQX1sxA4CSmNpFoNOxlg4Yk6S12fpTvKjEtuEt17NIDmJYI+HF3vNAwtTlNs+n2pdY42QSop6Qu/nHbeoA1Kd/1Y/jePwC3eO6R9msl/R6v3h2v7iIFa7WXLe8ueg1/nD+rkP5zNNULtlWegdE9ndWhY+kRr5/5TNVoLRbQjrTAjVWPop6XP1b7vPj4a8r5PY2BajjBSWnZArtnIuGp2YKc1tHLZAV+qTujekOFehizjAT1dhdlNirdkANbgeZuNLHv0dDHAYNcQ6tpTVnXKVOawzAAgcSdd3GY3LefTPd/hgNru6bUxKM+RK9JkuScuRsOAhPdnS3d2oHb7ZafzclClJELELmLHVlsbjIMi203k8zJvSrELXpU2amOvam7pbeqZ7Wvve6huQ1vMpszCvUcpTQu+Vmyi17KNTryNvMgcpxyy3eEt5aP+leI9dfsJ+UJU/6OxH/DVv3VT+7CY/V9j2OEIT2NgxIpiQCEIQFmX+UEf6on/WT/ALdWaiZvp2t8IO6qh+64+MsHmlQaztQfSMrCFMzQrds3zIBvY29xkqggUBRw95jcSt6i9wb32/xnZQBvkE2iZJvpIlInlOhY6yjlveXB7TKg4CU6Kb3lvgr5ix36RBM2evaJ75M2w3ZAEi4YZeP4RuNrg7zNI7bGUByTwlb00xVjRYg2brAPLq/zjsHtIIWuCxAvYcbf5j38pw23VZxQ6xshc1WUlcyA9jKpN9Ccr+zukEnols0m9ZxZeAM9BwA7JPf+A/xmC2dthqAWliEKDXI69qm+477DXxAPdNlsDFK6OVYMA28G+pG73e+L0q1EeI0CPAnMYvbYqYenUeo5LpXFWnUyF81N9OrN9AVJy5TpYrbuYnSalVwbUWzir1JBZgLM4FmGh0J3+e+XHTjZ9Svg3SkmaoGVgALsQD2gvfrew32nllWswp5CCr5lBvoQbdrQ7tU9pPOcc7cbqM5cNPXwT4nDo9EZquHBRk0BemdUZCd5XKRl4205G66HJ/WZ6eSoMgYMmVx6XMXym26cvk/R2pvVYWB7F+DMDckeH/lNawkwx3rL2SezIRbQndp3MIGEBIQhAIoiQgLKHpql8Gx5Oh+9b4y+nLGYVKtN6VQXRwVPPuI7wbEd4lHi9cxKL6SdtbZz4asaFUX4qw3OhvZh7N3AgiQvmpFyhuDwO+aEcPeow5AfiYtC71VW2gux8v8AG0r87JiAGBAZSNd19418vfLzZKABnO86DwH5n8JB3YWNuU5lo6s05oJR2pLLTCiQEEm0WtLBKZ7SuxLyVUfSQaykmwioi0wc113y8XZwxKP1m4oluAQ0xdSPG76/XYRuzMBrcyTtratPBojMmcu4Xqw2Vim92BBBGmnLMy98KqqVd8NUXDYmz0HF8zG2UcDfum86MbOSnTZqbEo5BF7HzB/ndJmzKVN6SuMlRHGdHKgkowBS9xobb7cZYKANALCZtAI8RscJAsx3TPostVXxNJT1+hZb6OFFri+47uNjY8d+xiiTLGWaqWbeUdBUrfPAlNwgAJqo5tnQaEBPpMCQQeHO1wfT2E8Y2vRKV3UjIUqOALWKlW7NrdxBB856l0TxT1cFSqVCTUIYFjvbI7IGPMkKNZy8d7xTH6WVoTraJOrQMSLCAkIQgEWJFgEcIgjhKMp8oeFR6FN2IDo9l5lWU5gPNVPtHGefu7BewQGuLA+rxnsG09k0cQEFZCwQkrZmG+1wbHUaD2Ty/pNslcNjGp07lGCuguSVDfQJOpsQbdxEsGU2hXbrFDjS4Itw11/GXOHfSddo9Haz0+syap2gNMxA36eENnbOquoNMAqdxJt8LyTKNXGzuGMbzqiy4w3ResdWdV7hdj+AlrhuhZIvUrFR3KLzW2WZQzqHmm/otRU/1lV/sAfwztS6KZj2VyjmzEn2bo2MuovxlvgNi1XAdaTFTuYjKv2msDNpsfozQo9srnqD6TWsPAbhKTpb8o2Fw10oEYjEDTKh/RofrONL9y3PhGxy2lSo4HDnEYypbeEop6VVuChjuHM20Gt543jse2IqvWqekx3C9lX6Krf6IGnv3mG2dtV8XVNfEVC7nQcFReCIu5V/k3OsioDY23ybH0B0OpZNnYUcTSRj4uM5/ilzOOBoBKSUxuSmiD9lQvwnUyBYoiRLyB8Iy8cDKK/aOwsNiDmrUVdt2a7K1huBZCCfOTMNhkp01p01y00GVVuTYDhcm5nWEmp2hLQiwlDI2OjZGhEiwhCRYQgKI4RojhKHiZPpXST5zTbKM+TVrC5GY2F/KawTL9M8IQExSn0LI4+qScrDlqSP2hM5/i6eLXymydlaiUzvdb+W74Sp6LIAhT1GKkeB0P8APKSsfiaRXD17kVncIp7RDKEYspHog6AjcTrMnj+ljYHF16PzcPZ73z5fTAYaZTwYcZjHt283T1LDU9JJXD336zx7EfKpiyLUqNBBzId29pYD7socd0vx9YFamLqZTvVCKYPcRTC3HjO23le47T2xhMKL4iuiH1b3c+CLdj7Jk9t/KlTpqGwuFdw+bJUqkIhynKxCi7Gx0scpnj3fxO/vms2xgAdhYPEW1SvXU+FRn3+dEe2NiBt7ppjsYCtasRTP+7p9imRyYA3f9omZ6NEUSB6Sy2TRz1qVP16lNPtuq/GV9OaPoRTDbRwoIuOsDeaBnHvUQPfHOsYTAwJgJCJeJeQPvAGcy0VWlHYGLOYMcDCHQiQlDY2OjTMqIQhAIRIsodFEaI4Qh4nLGYYVKb023OpW/K+4jvBsfKdBFlVkh0bxCIaaPSemd6vm9oFuzz0Jnm3yl7O6jFopUZ3pK7srOQxLMg9PW4CWvxuJ7vPKPlrodvC1bb1qoT/ZKMB99piYydN5eS5TVeYCPWMWdFmmAZ6auFL9FRYXKF38lxT5j9nNPMmntnQbCirsJaJ3PTxSfaqVV+MDw2KI1d0cIHWlNb8ntIttPD23L1jHuApVB+JHtmSp75uPkxX/ANwHdSqH3oPjA9jJjGMaxjC0BxaNLzmzRhaQdi8VHkYtHK0CYrToDIqNOymVHW8WMvEgPjYQkUkIQgEWEJQRwiwhDhFhCVRPNPlq/qcL/wBSr/AkISDyRZ1EIQBp7v8AJf8A7Lw/jV/79SJCB4NX9N/7TfxGNEIQOtObr5MP9oH/AKFT+OlCED1oxjwhIOTRrQhAaYqwhA7U52WLCUdIQhCP/9k="
    },
    {
      "images":
          "data:image/jpeg;base64,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"
    },
  ];

  List<Clothes> aroundClothes = [];
  Clothes? shopInfo;

  double latitude = 0, longitude = 0;

  Future refresh() async {
    SharedPreferences prefrs = await SharedPreferences.getInstance();
    aroundClothes = await getClothesInfo(
        prefrs.getDouble("latitude")!, prefrs.getDouble("longitude"));
    setState(() {});
  }

  //
  // Future fetch(List<String> a) async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('${dotenv.env["SERVER_URL"]}/clothes?a=$a&b=$b'));
  //     clothesInfo = json.encode(response.body);
  //     clothesInfo.map((clothes) => Clothes.fromJson(clothes)) as List<Clothes>;
  //
  //     setState(() {
  //     });
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }

  // final controller = ScrollController();
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //
  //   super.dispose();
  // }
  //
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   controller.addListener(() {
  //     if (controller.position.maxScrollExtent == controller.offset) {
  //       fetch();
  //     }
  //   });
  // }
  Future<void>? dataLoading;

  @override
  void initState() {
    super.initState();
    (() async {
      dataLoading = await refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<void>(
      future: dataLoading,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터가 아직 오지 않은 상태면 로딩 표시
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("연결 중입니다."),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } // 데이터가 오면 UI를 구성
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: aroundClothes.isNotEmpty
                ? CustomScrollView(
                    // controller: controller,
                    slivers: [
                      SliverAppBar(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        centerTitle: true,
                        title: const Text(
                          "Offline",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 2.0, // 선의 높이를 조절합니다.
                          color: Colors.black, // 선의 색상을 설정합니다.
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: TabBarDelegate(
                          maxHeight: 30,
                          minHeight: 30,
                          child: Container(
                            color: Theme.of(context).colorScheme.background,
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Text(
                              "경기도 용인시 처인구 고림동",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                        pinned: true,
                      ),
                      // SliverPersistentHeader(
                      //   delegate: TabBarDelegate(
                      //     maxHeight: 35,
                      //     minHeight: 35,
                      //     child: Container(
                      //       alignment: Alignment.bottomLeft,
                      //       margin:
                      //           const EdgeInsets.only(left: 20, bottom: 10),
                      //       child: const Text(
                      //         "주변에 있는 옷가게들이에요.",
                      //         style: TextStyle(
                      //             fontSize: 17, fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SliverPersistentHeader(
                      //   pinned: true,
                      //   delegate: TabBarDelegate(
                      //     maxHeight: size.width * 0.16,
                      //     minHeight: size.width * 0.16,
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: Theme.of(context).colorScheme.background,
                      //       ),
                      //       child: ListView.builder(
                      //         scrollDirection: Axis.horizontal,
                      //         itemCount: 2,
                      //         itemBuilder: (context, index) {
                      //           return InkWell(
                      //             onTap: () async {
                      //               Get.to(() => ShopInfoPage(
                      //                   shopInfo: test[index],
                      //                   shopInfos: test));
                      //             },
                      //               child: Container(
                      //                 alignment: Alignment.center,
                      //                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      //                 child: Column(
                      //                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   children: [
                      //                     Container(color: Colors.grey, height: 20, width: 20,),
                      //                     Text(
                      //                       "엄청난 옷을 파는 옷가게.",
                      //                       style: TextStyle(
                      //                         color: Theme.of(context)
                      //                             .colorScheme
                      //                             .primary,
                      //                         fontSize: size.height * 0.015,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SliverPersistentHeader(
                        delegate: TabBarDelegate(
                          maxHeight: 40,
                          minHeight: 40,
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "주변에 전시 된 옷들이에요",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 그리드 열 개수
                            mainAxisSpacing: 5, // 그리드 행 간 간격
                            crossAxisSpacing: 10.0, // 그리드 열 간 간격
                            childAspectRatio: (size.width / 2 - 20) /
                                (size.width * 0.75), // 아이템의 가로 세로 비율
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // if (index < clothesInfo.length) {
                              return UserHomeListItem(
                                clothesName: aroundClothes[index].name,
                                clothesImgPath: aroundClothes[index].images[0],
                                clothesPrice: aroundClothes[index].price,
                                discountRate: aroundClothes[index].discountRate,
                                shopName: aroundClothes[index].owner.shop.name,
                                onTap: () {
                                  Get.to(() => UserSelectedClothesPage(
                                      clothesInfo: aroundClothes[index]));
                                },
                              );
                              // } else {
                              //   return const Center(child: CircularProgressIndicator());
                              // }
                            },
                            childCount: aroundClothes.length, // 전체 아이템 개수
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
              alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "주변에 전시된 옷이 없어요...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.017,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await refresh();
                            setState(() {
                            });
                          },
                          icon: const Icon(Icons.refresh)),
                    ],
                  ),
                ),
          ),
        ); // 실제 위젯 반환
      },
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  TabBarDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(TabBarDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.child != child;
  }
}
