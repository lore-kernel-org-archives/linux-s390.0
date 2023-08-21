Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71471EE4996
	for <linux-s390@archiver.kernel.org>; Mon, 21 Aug 2023 13:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjHUNct (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Aug 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjHUNct (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Aug 2023 09:32:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A2A8
        for <linux-s390@vger.kernel.org>; Mon, 21 Aug 2023 06:32:47 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LDRctc026674;
        Mon, 21 Aug 2023 13:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5smBJS/yjG5SdZ3Ju51Sy9WkEOgWS4nztg0eEv57p4o=;
 b=k4dhnVDPZFVVKTtOIMeANe5jsIPcfEJSgqNTDsEulp/0jVn6tE1mtiCnqWuRlQELk5Mm
 zQMfbaBS59NkfTlLyCu5YqiL3TpYlPXj3eZheQ3jRRIGSCMPZ2B5NdrriArQz1bKLVZb
 Yg+Tr8jvwGGU35yCroGJ9AMHJmVNSjhaov27gVhKxzvKyyJ0I1/Jb67GtFP5GOtswKh4
 XLOAQyLy37eK4kSKIP5hMvDE5gNNNSiTKBUMfrdcwIGzOMP83sgbcxZe81tZTRWk0HWE
 ybohi97i8c9RtmDNZjO83S4hvhbnANdkOtY/gLxdAc90Go2tQWcnVZ4l/s7OuvVt78Kj qA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sm8u1r75n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 13:32:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37LCTDeu020705;
        Mon, 21 Aug 2023 13:32:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sk9jkb1rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 13:32:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37LDWZAt61014412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 13:32:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8AAF2004D;
        Mon, 21 Aug 2023 13:32:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0753620075;
        Mon, 21 Aug 2023 13:32:35 +0000 (GMT)
Received: from [9.179.30.164] (unknown [9.179.30.164])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Aug 2023 13:32:34 +0000 (GMT)
Message-ID: <52efd1aa02861c4683eefa1f1c15e8cac0b835c8.camel@linux.ibm.com>
Subject: Re: [PATCH -next] s390/pci: Use builtin_misc_device macro to
 simplify the code
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Li Zetao <lizetao1@huawei.com>, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Date:   Mon, 21 Aug 2023 15:32:34 +0200
In-Reply-To: <20230815080833.1103609-1-lizetao1@huawei.com>
References: <20230815080833.1103609-1-lizetao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -wUF5eHIJa-DXtTdmocfmxJ4H-v6pwVQ
X-Proofpoint-ORIG-GUID: -wUF5eHIJa-DXtTdmocfmxJ4H-v6pwVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210125
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

Sorry forgot to ask do you want me to take this via the s390 tree?
