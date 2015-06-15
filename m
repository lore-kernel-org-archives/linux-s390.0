Return-Path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150610110144.GA3249@vaishali-Ideapad-Z570>
References: <20150610110144.GA3249@vaishali-Ideapad-Z570>
Subject: Re: [PATCH] s390/zcrypt: Convert use of __constant_cpu_to_le16 to
 cpu_to_le16
Message-ID: <OFF084B8E6.E39F8680-ONC1257E65.004A3D02-C1257E65.004A8346@de.ibm.com>
From: Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>
Date: Mon, 15 Jun 2015 15:33:52 +0200
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=4EBBF4F6DFD9BB928f9e8a93df938690918c4EBBF4F6DFD9BB92"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: BOEBLINGEN LINUX390 <LINUX390@de.ibm.com>, heicars2@linux.vnet.ibm.com, Julia Lawall <julia.lawall@lip6.fr>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mschwid2@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

--0__=4EBBF4F6DFD9BB928f9e8a93df938690918c4EBBF4F6DFD9BB92
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: quoted-printable


Thanks for bringing up.
I pushed the patch into our internal repository, it will be upstream so=
on.

Mit freundlichen Gr=FC=DFen / Kind regards

Ingo Tuchscherer

Software Development - Linux on z Systems
IBM Systems &Technology Group
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
 Phone:            +49-7031-16-1986                 IBM Deutschland    =
                      (Embedded 
                                                                       =
                    image moved 
                                                                       =
                       to file: 
                                                                       =
                  pic03543.gif) 
                                                                       =
                                
 E-Mail:           ingo.tuchscherer@de.ibm.com      Schoenaicher Str. 2=
20                              
                                                                       =
                                
                                                    71032 Boeblingen   =
                                
                                                                       =
                                
                                                    Germany            =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
                                                                       =
                                
 IBM Deutschland                                                       =
                                
 Research &                                                            =
                                
 Development                                                           =
                                
 GmbH /                                                                =
                                
 Vorsitzender des                                                      =
                                
 Aufsichtsrats:                                                        =
                                
 Martina Koederitz                                                     =
                                
                                                                       =
                                
 Gesch=E4ftsf=FChrung:                                                 =
                                    
 Dirk Wittkopp                                                         =
                                
 Sitz der                                                              =
                                
 Gesellschaft:                                                         =
                                
 B=F6blingen /                                                         =
                                  
 Registergericht:                                                      =
                                
 Amtsgericht                                                           =
                                
 Stuttgart, HRB                                                        =
                                
 243294                                                                =
                                
                                                                       =
                                





From:	Vaishali Thakkar <vthakkar1994@gmail.com>
To:	Ingo Tuchscherer/Germany/IBM@IBMDE
Cc:	BOEBLINGEN LINUX390/Germany/IBM@IBMDE,
            mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
            linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, J=
ulia
            Lawall <julia.lawall@lip6.fr>
Date:	06/10/2015 01:01 PM
Subject:	[PATCH] s390/zcrypt: Convert use of __constant_cpu_to_le16 to
            cpu_to_le16



In big endian cases, the macro cpu_to_le16 unfolds to __swab16
which provides special case for constants. In little endian cases,
__constant_cpu_to_le16 and cpu_to_le16 expand directly to the
same expression. So, replace __constant_cpu_to_le16 with
cpu_to_le16 with the goal of getting rid of the definition of
__constant_cpu_to_le16 completely.

The semantic patch that performs this transformation is as follows:

@@expression x;@@

- __constant_cpu_to_le16(x)
+ cpu_to_le16(x)

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/s390/crypto/zcrypt_pcicc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_pcicc.c
b/drivers/s390/crypto/zcrypt_pcicc.c
index 4d14c04..9f18876 100644
--- a/drivers/s390/crypto/zcrypt_pcicc.c
+++ b/drivers/s390/crypto/zcrypt_pcicc.c
@@ -98,11 +98,11 @@ static struct ap_driver zcrypt_pcicc_driver =3D {
  * - VUD block
  */
 static struct CPRB static_cprb =3D {
-		 .cprb_len		 =3D __constant_cpu_to_le16(0x0070),
+		 .cprb_len		 =3D cpu_to_le16(0x0070),
 		 .cprb_ver_id		 =3D  0x41,
 		 .func_id		 =3D {0x54,0x32},
 		 .checkpoint_flag=3D  0x01,
-		 .svr_namel		 =3D __constant_cpu_to_le16(0x0008),
+		 .svr_namel		 =3D cpu_to_le16(0x0008),
 		 .svr_name		 =3D {'I','C','S','F',' ',' ',' ',' '}
 };

@@ -164,7 +164,7 @@ static int ICAMEX_msg_to_type6MEX_msg(struct
zcrypt_device *zdev,
 		 };
 		 static struct function_and_rules_block
static_pke_function_and_rules =3D{
 		 		 .function_code		 =3D {'P','K'},
-		 		 .ulen		 		 =3D
__constant_cpu_to_le16(10),
+		 		 .ulen		 		 =3D cpu_to_le16(10),
 		 		 .only_rule		 =3D
{'P','K','C','S','-','1','.','2'}
 		 };
 		 struct {
@@ -251,7 +251,7 @@ static int ICACRT_msg_to_type6CRT_msg(struct
zcrypt_device *zdev,
 		 };
 		 static struct function_and_rules_block
static_pkd_function_and_rules =3D{
 		 		 .function_code		 =3D {'P','D'},
-		 		 .ulen		 		 =3D
__constant_cpu_to_le16(10),
+		 		 .ulen		 		 =3D cpu_to_le16(10),
 		 		 .only_rule		 =3D
{'P','K','C','S','-','1','.','2'}
 		 };
 		 struct {
--
1.9.1

=

--0__=4EBBF4F6DFD9BB928f9e8a93df938690918c4EBBF4F6DFD9BB92
Content-type: image/gif;
	name="pic03543.gif"
Content-Disposition: attachment; filename="pic03543.gif"
Content-transfer-encoding: base64

R0lGODlhVwAeAPcAAAAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8ER3u8bGxv///wAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAP/78KCgpICAgP8AAAD/AP//AAAA//8A/wD//////yH5BAAAAAAALAAAAABXAB4A
hwAAAIAAAACAAICAAAAAgIAAgACAgMDAwMDcwKbK8ER3u8bGxv///wAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/7
8KCgpICAgP8AAAD/AP//AAAA//8A/wD//////wj+ABcoGEiwYMEFDAQaXGhwAUIGEBMyLBixIsSJ
By1qVIiRIEKOHRc+hAiS4ciKJU1qXMmypcuXMGPKnEmzps2bLlNO/Biy40OdBlf2VHByJVCREoeq
TOrT4tGMOKNKnUq1qtWrDBjmDIoSacWOFpve1NqypNOFGsUyXYq1rdu3cOO2JMvyKdq0Te0WnUnX
qFKiQkUebOhVruHDiBPD7Lvx796sDddmLFyT8dm/gaFOvBhZsefPoN9a7kqRdOmvnVNGpExzdESz
pj2G7QxZNmeooXPr3o1aAUmlPP/ePToSZG+2F1dLxhhcuG3ivU+qzZpVIHXecH0PTI5dNHXtdmUZ
h9/5mnnXotOvUx8PmP3Bk9C/4iU/2zeDgAA7

--0__=4EBBF4F6DFD9BB928f9e8a93df938690918c4EBBF4F6DFD9BB92--
