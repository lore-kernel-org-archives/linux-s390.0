Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57301C77B73
	for <linux-s390@archiver.kernel.org>; Mon,  1 May 2023 15:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEAPHj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 May 2023 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEAPHi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 May 2023 11:07:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7521B3
        for <linux-s390@vger.kernel.org>; Mon,  1 May 2023 08:07:34 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341F5TXq024706;
        Mon, 1 May 2023 15:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TkIh8xee12jmi/5z3t69UQu1xTrgqEu2MVK4Wnvomz4=;
 b=no8nXz9LCPh4/SZATAcT2BPQ4ZvnBegF1NAX21q9ruKYH+/ls2FWUIEJwGydr9SN2TBr
 s6JA9k2dFrLtD4OKfMqZK8Kcuwvl17tdBComG8HYh43DoFX18YCzdyeBqCKkrn1y/J4l
 /07nDwtC4lex4Y5Il8PPyyntKOiQAXEUXcM4Ui29KywjlNqXQEqovPOEZmuKcG6xOSP+
 g6r57X788IAi96D/Y4LWjXrW+xi0K0jKSJo5UsQFxQJIxnVECb79JpQ9Rc0DK20KU7SZ
 +TPecg1PIeBV8n6+XO5lxHqqLa1dIMjshWX6AR/6wnLlZg60uoYPclE/z2O57nX/B2ib VQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q9qtrbrsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 15:07:11 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 341EJkLS011835;
        Mon, 1 May 2023 15:06:55 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3q8tv7jpph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 15:06:55 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 341F6rca12911196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 May 2023 15:06:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6017158060;
        Mon,  1 May 2023 15:06:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2433758063;
        Mon,  1 May 2023 15:06:52 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.160.25.185])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  1 May 2023 15:06:52 +0000 (GMT)
Message-ID: <07a891513e1083eab901af4dfa630bd60f93479d.camel@linux.ibm.com>
Subject: Re: [PATCH] iommu/s390: Get rid of S390_CCW_IOMMU
From:   Eric Farman <farman@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, linux-s390@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        "Jason J. Herne" <jjherne@linux.ibm.com>
Date:   Mon, 01 May 2023 11:06:51 -0400
In-Reply-To: <0-v1-11a50d289ac9+b6-rm_iommu_ccw_jgg@nvidia.com>
References: <0-v1-11a50d289ac9+b6-rm_iommu_ccw_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FY32rJk2HkdWl0tlhgnZbjHroVheaQzz
X-Proofpoint-ORIG-GUID: FY32rJk2HkdWl0tlhgnZbjHroVheaQzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=841 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010121
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2023-04-28 at 16:28 -0300, Jason Gunthorpe wrote:
> This doesn't do anything anymore, the only user of the symbol was
> VFIO_CCW
> which already "depends on VFIO" and VFIO selects IOMMU_API.

The "depends on VFIO" statement came from commit de858a05c9d8 ("vfio-
mdev: add back CONFIG_VFIO dependency"). This isn't really a fix to
that one, but it does follow that set of changes.

>=20
> When this was added VFIO was wrongly doing "depends on IOMMU_API"

(later fixed by commit 179209fa1270 ("vfio: IOMMU_API should be
selected"))

> which
> required some mess like this to ensure IOMMU_API was turned on.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

What of S390_AP_IOMMU? Seems to have been borrowed from the _CCW hunks
being removed here, and is now equally redundant (though I have not
tried).

Regardless, for this:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
> =C2=A0arch/s390/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0arch/s390/configs/debug_defconfig | 1 -
> =C2=A0arch/s390/configs/defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
 -
> =C2=A0drivers/iommu/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 --------
> =C2=A04 files changed, 11 deletions(-)
>=20
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 9809c74e124060..9334500078f978 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -714,7 +714,6 @@ config EADM_SCH
> =C2=A0config VFIO_CCW
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0def_tristate n
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prompt "Support for VFIO-=
CCW subchannels"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on S390_CCW_IOMMU
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on VFIO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select VFIO_MDEV
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> diff --git a/arch/s390/configs/debug_defconfig
> b/arch/s390/configs/debug_defconfig
> index 4ccf66d29fc24b..77b886e1b867d4 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -591,7 +591,6 @@ CONFIG_VIRTIO_BALLOON=3Dm
> =C2=A0CONFIG_VIRTIO_INPUT=3Dy
> =C2=A0CONFIG_VHOST_NET=3Dm
> =C2=A0CONFIG_VHOST_VSOCK=3Dm
> -CONFIG_S390_CCW_IOMMU=3Dy
> =C2=A0CONFIG_S390_AP_IOMMU=3Dy
> =C2=A0CONFIG_EXT4_FS=3Dy
> =C2=A0CONFIG_EXT4_FS_POSIX_ACL=3Dy
> diff --git a/arch/s390/configs/defconfig
> b/arch/s390/configs/defconfig
> index 693297a2e89733..36ab9b1956245c 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -580,7 +580,6 @@ CONFIG_VIRTIO_BALLOON=3Dm
> =C2=A0CONFIG_VIRTIO_INPUT=3Dy
> =C2=A0CONFIG_VHOST_NET=3Dm
> =C2=A0CONFIG_VHOST_VSOCK=3Dm
> -CONFIG_S390_CCW_IOMMU=3Dy
> =C2=A0CONFIG_S390_AP_IOMMU=3Dy
> =C2=A0CONFIG_EXT4_FS=3Dy
> =C2=A0CONFIG_EXT4_FS_POSIX_ACL=3Dy
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index db98c3f86e8c8b..b1f9d82b4ec9ae 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -417,14 +417,6 @@ config S390_IOMMU
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support for the IO=
MMU API for s390 PCI devices.
> =C2=A0
> -config S390_CCW_IOMMU
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "S390 CCW IOMMU Support"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on S390 && CCW || COMP=
ILE_TEST
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select IOMMU_API
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enables bits of IOMMU A=
PI required by VFIO. The iommu_ops
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is not implemented as i=
t is not necessary for VFIO.
> -
> =C2=A0config S390_AP_IOMMU
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "S390 AP IOMMU Suppo=
rt"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on S390 && ZCRYPT=
 || COMPILE_TEST
>=20
> base-commit: 57d60ea1868f36586c85f6f6692cf4bc49affecd

