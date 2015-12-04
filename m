Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 4 Dec 2015 18:57:31 +0100
From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH] SCSI-zfcp: Delete unnecessary checks before the function
 call "mempool_destroy"
Message-ID: <20151204175731.GA9185@bblock-ThinkPad-W530>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <5649D8DE.1030809@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <5649D8DE.1030809@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hej Markus,

On 14:23 Mon 16 Nov     , SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 16 Nov 2015 14:19:03 +0100
>=20
> The mempool_destroy() function tests whether its argument is NULL
> and then returns immediately. Thus the test around the calls is not neede=
d.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index c00ac46..abc9c93 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers(struct zfc=
p_adapter *adapter)
>=20
>  static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
>  {
> -	if (adapter->pool.erp_req)
> -		mempool_destroy(adapter->pool.erp_req);
> -	if (adapter->pool.scsi_req)
> -		mempool_destroy(adapter->pool.scsi_req);
> -	if (adapter->pool.scsi_abort)
> -		mempool_destroy(adapter->pool.scsi_abort);
> -	if (adapter->pool.qtcb_pool)
> -		mempool_destroy(adapter->pool.qtcb_pool);
> -	if (adapter->pool.status_read_req)
> -		mempool_destroy(adapter->pool.status_read_req);
> -	if (adapter->pool.sr_data)
> -		mempool_destroy(adapter->pool.sr_data);
> -	if (adapter->pool.gid_pn)
> -		mempool_destroy(adapter->pool.gid_pn);
> +	mempool_destroy(adapter->pool.erp_req);
> +	mempool_destroy(adapter->pool.scsi_req);
> +	mempool_destroy(adapter->pool.scsi_abort);
> +	mempool_destroy(adapter->pool.qtcb_pool);
> +	mempool_destroy(adapter->pool.status_read_req);
> +	mempool_destroy(adapter->pool.sr_data);
> +	mempool_destroy(adapter->pool.gid_pn);
>  }
>=20
>  /**
> --=20
> 2.6.2

Looks good to me, will have to wait though till Steffen is back around.

Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>


                                                    Beste Gr=FC=DFe / Best =
regards,
                                                      - Benjamin Block
--=20
Linux on z Systems Development         /         IBM Systems & Technology G=
roup
		  IBM Deutschland Research & Development GmbH=20
Vorsitz. AufsR.: Martina Koederitz     /        Gesch=E4ftsf=FChrung: Dirk =
Wittkopp
Sitz der Gesellschaft: B=F6blingen / Registergericht: AmtsG Stuttgart, HRB =
243294

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWYdQLAAoJEPM2BBqBwGE1/u0QALS6GRu2f+8C1pzC9vo9/6/Z
zWu7twgg5SRhSGhWyWIFHGK9JYJTn1rGhzusXFxxPT25CYdWRFtFZDY8w5kqOsJ6
6rJE2jkCWSXXC4v9FP4DgffUUbH80ZKoE8TjnQFmnYTlPiZVFu9fBbuP1b3duBDy
Q6L1HiFQ8uH5RIMKGzfNozMV0ogbN5BHTEZCPKWsPbUaPxQpWb99Z5E+i6nBBgaN
jYbDQeu/DwNAZv8pmx0IJcvKU/oQQZH3Vt2lBvtEPmJgAlTBupOVaPqMvd+i/RCA
z+8xOsYiWtZhqyY3GMyVvv+eyPTSsCwx9AsmkeV3YP1JXROM/pOqcxzsml2s0Ykt
0Pl9es0HjEpJIlhOjLxqIjNXao2SCGjSunhBUwlz6rDdrh/WAdS9eGAu2outl33q
Td35DsZSm5x1zC6MVPQ18TJHTotnch2j8uBAIxcbz+mQgon2LWfoUOsoRBvxMSUz
jPJ/b6o7dmuS05gBp8VDCM/Jx7vO8CiAbos2fyCML0xlsC4vxnuXMGg5NuJQswaO
biZt2snP4TezdxoXPzOTc8e8qJzPCsgkaACxip0PSAHO7fFc32JojEWBG2FUyOrA
yHcRgObwU0oYztqPkJQlMmDc0OBCn1VIWrmEDDcChIc3Cg/wnbZlmSOnO8dAXQnG
jYFSeySm2PwVrokfZak9
=klwj
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
