Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F92CEE4996
	for <linux-s390@archiver.kernel.org>; Mon, 21 Aug 2023 13:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjHUNgI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Aug 2023 09:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjHUNgH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Aug 2023 09:36:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75784FB
        for <linux-s390@vger.kernel.org>; Mon, 21 Aug 2023 06:36:00 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LDV8Kf004018;
        Mon, 21 Aug 2023 13:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bpUNpqnkukKDP+VYSf5eJordgsSti+2KdRIVh/y8CuQ=;
 b=NzCJQZ8jlnoWFYguVqiNdI+l0ksAkyOTSOcfYsfGoWQLk2So6uVYELtQAXaKCl3plsjV
 dV6pX7sD7znkIMsOUvSJuD/bGOgP23tIvphu8SMGsJ7SgA6/FWQ3Hpn8T5NUmkOa4cME
 J4UXg6qiqF6YIkvk8uWcT3LLci2N5S/tR9nVKnNuFh2pPSgatfMym8xbYr219nz4xNZ7
 gkv7AjANexzDIyW3Dwll8as3cHhX8kMISLFskNjlj1zaZTBffE7pV7sHKYezJul/1fKb
 vyf0wQcnARt33p5BrMdK/YgEPyG36Rfr3HFrUpotMwXROgNahFCnBr7BtJQzidm8qhOb KQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sm8vjgcsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 13:35:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37LD8igV015821;
        Mon, 21 Aug 2023 13:30:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sk8ey3fx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 13:30:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37LDUgak14811850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 13:30:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 400A42004D;
        Mon, 21 Aug 2023 13:30:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C135A2004F;
        Mon, 21 Aug 2023 13:30:41 +0000 (GMT)
Received: from [9.179.30.164] (unknown [9.179.30.164])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Aug 2023 13:30:41 +0000 (GMT)
Message-ID: <b635131117ce4a2acb52913140705e52f2bfe7cf.camel@linux.ibm.com>
Subject: Re: [PATCH -next] s390/pci: Use builtin_misc_device macro to
 simplify the code
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Li Zetao <lizetao1@huawei.com>, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Date:   Mon, 21 Aug 2023 15:30:41 +0200
In-Reply-To: <20230815080833.1103609-1-lizetao1@huawei.com>
References: <20230815080833.1103609-1-lizetao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UNVmxD2SDYPMUqcHcEAmrp-oNjkpHH2C
X-Proofpoint-GUID: UNVmxD2SDYPMUqcHcEAmrp-oNjkpHH2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210125
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 2023-08-15 at 16:08 +0800, Li Zetao wrote:
> Use the builtin_misc_device macro to simplify the code, which is the same
> as declaring with device_initcall().
>=20
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  arch/s390/pci/pci_clp.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index ee367798e388..ee90a91ed888 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -666,9 +666,4 @@ static struct miscdevice clp_misc_device =3D {
>  	.fops =3D &clp_misc_fops,
>  };
> =20
> -static int __init clp_misc_init(void)
> -{
> -	return misc_register(&clp_misc_device);
> -}
> -
> -device_initcall(clp_misc_init);
> +builtin_misc_device(clp_misc_device);

Thanks, makes sense to me.

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
