Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfFPQZ6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 16 Jun 2019 12:25:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5GGMCcq144699
        for <linux-s390@vger.kernel.org>; Sun, 16 Jun 2019 12:25:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t5dn0ykgt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sun, 16 Jun 2019 12:25:57 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Sun, 16 Jun 2019 17:25:54 +0100
Date: Sun, 16 Jun 2019 18:25:46 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V3 09/15] s390: zfcp_fc: use sg helper to operate
 scatterlist
References: <20190614025316.7360-1-ming.lei@redhat.com>
 <20190614025316.7360-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190614025316.7360-10-ming.lei@redhat.com>
Message-Id: <20190616162546.GB6610@t480-pf1aa2c2>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>, Cathy Avery <cavery@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>, Brian King <brking@us.ibm.com>, James Smart <james.smart@broadcom.com>, "Juergen E . Fischer" <fischer@norbit.de>, Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Steffen Maier <maier@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

On Fri, Jun 14, 2019 at 10:53:10AM +0800, Ming Lei wrote:
> Use the scatterlist iterators and remove direct indexing of the
> scatterlist array.
>=20
> This way allows us to pre-allocate one small scatterlist, which can be
> chained with one runtime allocated scatterlist if the pre-allocated one
> isn't enough for the whole request.
>=20
> Cc: Steffen Maier <maier@linux.ibm.com>
> Cc: Benjamin Block <bblock@linux.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/s390/scsi/zfcp_fc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index 33eddb02ee30..b018b61bd168 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -620,7 +620,7 @@ static void zfcp_fc_sg_free_table(struct scatterlist =
*sg, int count)
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < count; i++, sg++)
> +	for (i =3D 0; i < count; i++, sg =3D sg_next(sg))
>  		if (sg)
>  			free_page((unsigned long) sg_virt(sg));
>  		else
> @@ -641,7 +641,7 @@ static int zfcp_fc_sg_setup_table(struct scatterlist =
*sg, int count)
>  	int i;
> =20
>  	sg_init_table(sg, count);
> -	for (i =3D 0; i < count; i++, sg++) {
> +	for (i =3D 0; i < count; i++, sg =3D sg_next(sg)) {
>  		addr =3D (void *) get_zeroed_page(GFP_KERNEL);
>  		if (!addr) {
>  			zfcp_fc_sg_free_table(sg, i);

Acked-by: Benjamin Block <bblock@linux.ibm.com>

--=20
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Develop=
ment
IBM Systems & Technology Group   /  IBM Deutschland Research & Development =
GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
