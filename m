Date: Mon, 16 Jul 2012 13:14:38 +0300
From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH net-next 0/8] etherdevice: Rename random_ether_addr to
 eth_random_addr
Message-ID: <20120716101437.GC22638@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
References: <1341968967.13724.23.camel@joe2Laptop>
 <cover.1342157022.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <cover.1342157022.git.joe@perches.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, wimax@linuxwimax.org, linux-wireless@vger.kernel.org, users@rt2x00.serialmonkey.com, linux-s390@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-mips@linux-mips.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, e1000-devel@lists.sourceforge.net
List-ID: <linux-s390.vger.kernel.org>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2012 at 10:33:04PM -0700, Joe Perches wrote:
> net-next commit ad7eee98be ("etherdevice: introduce eth_broadcast_addr")
> added a new style API.  Rename random_ether_addr to eth_random_addr to
> create some API symmetry.
>=20
> Joe Perches (8):
>   etherdevice: Rename random_ether_addr to eth_random_addr

if you're really renaming the function, then this patch alone will break
all of the below users. That should all be a single patch, I'm afraid.

>   ethernet: Use eth_random_addr
>   net: usb: Use eth_random_addr
>   wireless: Use eth_random_addr
>   drivers/net: Use eth_random_addr
>   s390: Use eth_random_addr
>   usb: Use eth_random_addr
>   arch: Use eth_random_addr
>=20
>  arch/blackfin/mach-bf537/boards/stamp.c           |    2 +-
>  arch/c6x/kernel/soc.c                             |    2 +-
>  arch/mips/ar7/platform.c                          |    4 ++--
>  arch/mips/powertv/powertv_setup.c                 |    6 +++---
>  arch/um/drivers/net_kern.c                        |    2 +-
>  drivers/net/ethernet/atheros/atl1c/atl1c_hw.c     |    2 +-
>  drivers/net/ethernet/atheros/atlx/atl1.c          |    2 +-
>  drivers/net/ethernet/atheros/atlx/atl2.c          |    2 +-
>  drivers/net/ethernet/ethoc.c                      |    2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c         |    4 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    |    2 +-
>  drivers/net/ethernet/lantiq_etop.c                |    2 +-
>  drivers/net/ethernet/micrel/ks8851.c              |    2 +-
>  drivers/net/ethernet/micrel/ks8851_mll.c          |    2 +-
>  drivers/net/ethernet/smsc/smsc911x.c              |    2 +-
>  drivers/net/ethernet/ti/cpsw.c                    |    2 +-
>  drivers/net/ethernet/tile/tilegx.c                |    2 +-
>  drivers/net/ethernet/wiznet/w5100.c               |    2 +-
>  drivers/net/ethernet/wiznet/w5300.c               |    2 +-
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    2 +-
>  drivers/net/tun.c                                 |    2 +-
>  drivers/net/usb/smsc75xx.c                        |    2 +-
>  drivers/net/usb/smsc95xx.c                        |    2 +-
>  drivers/net/usb/usbnet.c                          |    2 +-
>  drivers/net/wimax/i2400m/driver.c                 |    2 +-
>  drivers/net/wireless/adm8211.c                    |    2 +-
>  drivers/net/wireless/p54/eeprom.c                 |    2 +-
>  drivers/net/wireless/rt2x00/rt2400pci.c           |    2 +-
>  drivers/net/wireless/rt2x00/rt2500pci.c           |    2 +-
>  drivers/net/wireless/rt2x00/rt2500usb.c           |    2 +-
>  drivers/net/wireless/rt2x00/rt2800lib.c           |    2 +-
>  drivers/net/wireless/rt2x00/rt61pci.c             |    2 +-
>  drivers/net/wireless/rt2x00/rt73usb.c             |    2 +-
>  drivers/net/wireless/rtl818x/rtl8180/dev.c        |    2 +-
>  drivers/net/wireless/rtl818x/rtl8187/dev.c        |    2 +-
>  drivers/s390/net/qeth_l2_main.c                   |    2 +-
>  drivers/s390/net/qeth_l3_main.c                   |    2 +-
>  drivers/usb/atm/xusbatm.c                         |    4 ++--
>  drivers/usb/gadget/u_ether.c                      |    2 +-
>  include/linux/etherdevice.h                       |   14 ++++++++------
>  40 files changed, 52 insertions(+), 50 deletions(-)
>=20
> --=20
> 1.7.8.111.gad25c.dirty
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
balbi

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQA+mNAAoJEIaOsuA1yqRE+ksP/Alli7QgsqKkod+QSJZRmYS6
wJJT+g2ZqoMatSweM3ZCXzeGMBspr3j0TtRqcLxugkaNullhyfqLmyXAW3FQIboF
Aw40vVRTZSjTmecHJB53QVMZ+u+lGKu7u5YAvF+ixof9AXZYPppTEghxHdCtdKou
SpkRsOgw+DwgftlGma27DAiAGTSuV59c74NiOmpCazv2w/TSNF63AkNEfyUH9Cqv
nT7M89z7BJDGoUKKULpN/wKlCl6qWNEtOWShjAmkmhYJBnsIMGEX+w5/4RO8ABOK
p82KlsEl0+Ze5dZGJ1sy64Cs9a50dqIrDcPHtnKwACZqwj9SI6uQSpa9spX5qlqA
64CQzBaudcBcLKzeXlzvOfZmbVbPIXd/wtFXlbYCKGd2Gl+3F211yL7fzd++3RDR
0bIm5vjUjf/c6830awVc6JRUtnLsEzdNnwpNPlm9oCSu5p7TwEGQkhblI7TyYRNV
/Xl5sPiSmIlHfV073zXco8CyuXdHnAUdY7Ujg98KXcXds7AxDd3R4wRa9KykGyVf
Vb4TZ5Rk2bXaFOnfqAT2+aGOGyox/504ud1KVdBvLFc4VLkv4/DN1syiNjDtORu3
Ls+uNzP85uB5c5p49fvM56Mwjzfql47PRKi86OdPebfFCKmLGoVi8k2aHioTvCMO
7qp9s0cYaXJREqb3n+Yb
=EBK7
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
