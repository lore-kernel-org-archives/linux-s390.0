Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731168AbfFMIlp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 04:41:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5D8bPbK105349
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 04:41:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t3k2vrccw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Jun 2019 04:41:43 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Thu, 13 Jun 2019 09:41:42 +0100
Date: Thu, 13 Jun 2019 10:41:35 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V2 09/15] s390: zfcp_fc: use sg helper to operate sgl
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-10-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190613071335.5679-10-ming.lei@redhat.com>
Message-Id: <20190613084135.GA18038@t480-pf1aa2c2>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>, Cathy Avery <cavery@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>, Brian King <brking@us.ibm.com>, James Smart <james.smart@broadcom.com>, "Juergen E . Fischer" <fischer@norbit.de>, Michael Schmitz <schmitzmic@gmail.com>, Finn Thain <fthain@telegraphics.com.au>, Steffen Maier <maier@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org

On Thu, Jun 13, 2019 at 03:13:29PM +0800, Ming Lei wrote:
> The current way isn't safe for chained sgl, so use sg helper to
> operate sgl.
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

Color more confused. Where did the rest of this patch-set go? I don't
see any other patches from this series of 15 on linux-scsi? Neither on
my mail-account, nor on the archive https://marc.info/?l=3Dlinux-scsi

I was looking for a bit more context.

--=20
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Develop=
ment
IBM Systems & Technology Group   /  IBM Deutschland Research & Development =
GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
