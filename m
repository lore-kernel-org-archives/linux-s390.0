From: Ben Hutchings <ben@decadent.org.uk>
Subject: Input: Add missing dependencies on CONFIG_HAS_IOMEM
Date: Sun, 09 Jun 2013 21:02:52 +0100
Message-ID: <1370808172.5614.8.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tr08wpWxUK2G1XLzI4FH"
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-input/>
List-Post: <mailto:linux-input@vger.kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Debian kernel maintainers <debian-kernel@lists.debian.org>, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--=-tr08wpWxUK2G1XLzI4FH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Several drivers don't build on s390 with CONFIG_PCI disabled as
they require MMIO functions.

Marking this for 3.9-stable only, as CONFIG_INPUT was previously
disabled on s390.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org # 3.9
---
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -431,6 +431,7 @@ config KEYBOARD_TEGRA
=20
 config KEYBOARD_OPENCORES
 	tristate "OpenCores Keyboard Controller"
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you want to use the OpenCores Keyboard Controller
 	  http://www.opencores.org/project,keyboardcontroller
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -205,6 +205,7 @@ config SERIO_XILINX_XPS_PS2
=20
 config SERIO_ALTERA_PS2
 	tristate "Altera UP PS/2 controller"
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you have Altera University Program PS/2 ports.
=20


--=-tr08wpWxUK2G1XLzI4FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUbTfbOe/yOyVhhEJAQpZ8RAA0J6BzdAyYNxI61/7NMoe8/O7Q2Bo6kYx
wQAur0RO+wF+OfR4vms6JO88taJw4gPeDwwO+H6qdJvB7dLXomynwoYUEj1SCaKB
sFilrotYBSmITi350dWYsHOk0sKQ44ixZjG7XtEnDZ3WNBQdzDMYVuq9Za0uZxji
kpX8esuMVyiA/Nr974UoxOOy6KJsL5ze77qxrodNdilVNtQE3nJWIUi9rrGE5il8
YOACGvpR/443RB/hSL1N3f28IETLz1o1vZBESCZR5rJ9qhJHHM/8oFbIuwhZGu0f
Bw17qhjHpyFcRqu0STiN5Iz73GlfiPSpo/TyRlFMcpmxWD/IKzzhxpWLOmjSQbcD
+5/7xuYDh9/Awb0QdFMY/wke/eS1peIbUgGvJ/3QBrDd9LBg8w8/h3gJchyCq68D
MoKsfOrx3/uKtYWIQekDNqV615dCzryoEqT8MyTHsKwoI9GOGEnVJVEpIHRHjVfZ
ZJxOvaKaogm8ZXp8N8NYq9fdfQdP1zPv8nPGTFOCXkWcX6f91dy1xfKpyHUqrlAm
EN9+pDCdLG6FayDW+EZPpe5+DMgQ7uWMG1O8wr2C07lFUlok1waFqrL9J2CVKFEN
d6eQ7OYSApwoG9o8pr/wV4AB6PnkNSfF8PCyjAAjlpcANa1AwwXt+dw4QeR/4Rtc
sH3t+O/n2AE=
=cQVT
-----END PGP SIGNATURE-----

--=-tr08wpWxUK2G1XLzI4FH--
