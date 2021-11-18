Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E384CC433F5
	for <linux-s390@archiver.kernel.org>; Thu, 18 Nov 2021 08:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55D1619BB
	for <linux-s390@archiver.kernel.org>; Thu, 18 Nov 2021 08:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbhKRI5a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:57:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244815AbhKRI4r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Nov 2021 03:56:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI75pEf026897;
        Thu, 18 Nov 2021 08:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wC98a+CW1L2VADEvo6Dmf/nqIylCFF1d3qUmNwcLBJw=;
 b=ib+J11zpWL7MFz1eubqVW/0iPTsSRMz9+9nRclrt4n3rXCnbZsyjexhOwvZdBHlDih6B
 w1vq5bI3DWNwRH5WwHs0UlVEKEB4DKflN4j7Awpcka9hLyy1pIRK6SJS35KbL4Hy9gHS
 mnOY6V7gRrRJxs5nR10K6BGBCwgmHu/Ve9Sc+b5CC+Td4y1UhhKISSckoydqC6GVi8wf
 sMx732AhsH70iWuaTFeDY4amYf4928L5diF28IsHIVTv9z0R/CMoHqcqzqjJ9DR2gq5z
 OgHvNAXpePPQ5C1ZWrMhO5jkwYSR2zwRkM6AyVTNypG+u6CJUvE2lqP9IbvxN6tpB1ow iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdgwu3n70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 08:53:39 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AI8oKrp010700;
        Thu, 18 Nov 2021 08:53:39 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdgwu3n63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 08:53:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AI8r9VD001790;
        Thu, 18 Nov 2021 08:53:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3ca50bk4xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 08:53:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AI8rXOa852630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 08:53:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26AF15204E;
        Thu, 18 Nov 2021 08:53:33 +0000 (GMT)
Received: from osiris (unknown [9.145.3.76])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CFE0152050;
        Thu, 18 Nov 2021 08:53:32 +0000 (GMT)
Date:   Thu, 18 Nov 2021 09:53:31 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, prudo@redhat.com
Subject: Re: [PATCH v2 2/2] s390/kexec: fix kmemleak
Message-ID: <YZYUi9XMyjtpGmAQ@osiris>
References: <20211116032557.14075-2-bhe@redhat.com>
 <202111180539.e7kmpOSP-lkp@intel.com>
 <20211118071327.GF21646@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118071327.GF21646@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tjh5oamRJKuuTU60n7_kOAtrssS2cdGp
X-Proofpoint-GUID: xaUtqSrKmZmugcbAmpwz8qrgXKdMQZF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_04,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=757 adultscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180049
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 18, 2021 at 03:13:27PM +0800, Baoquan He wrote:
> On 11/18/21 at 05:46am, kernel test robot wrote:
> >    arch/s390/kernel/machine_kexec_file.c: In function 'arch_kimage_file_post_load_cleanup':
> > >> arch/s390/kernel/machine_kexec_file.c:332:9: error: implicit declaration of function 'kvfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
> >      332 |         kvfree(image->arch.ipl_buf);
> >          |         ^~~~~~
> >          |         vfree
> 
> OK, kvfree is not wrong, seems vfree is more appropriate since it's
> clear the ipl_buf is allocated with zvalloc() in ipl_report_finish().
> 
> Hi Heiko,
> 
> Could you help modify the code in your tree or append below patch to
> mute the lkp complaint? Sorry for the inconvenience.
...
>  arch/s390/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 7f51837e9bc2..351a7ff69a43 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -329,7 +329,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  
>  int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  {
> -	kvfree(image->arch.ipl_buf);
> +	vfree(image->arch.ipl_buf);

The problem reported above indicates that slab.h was not
included. With your patch, while it fixes the problem for this
particular configuration, this requires vmalloc.h to be included.

I'll merge your patch and add the missing include as well.
