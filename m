Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C2DC47082
	for <linux-s390@archiver.kernel.org>; Mon, 31 May 2021 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E3F60FEF
	for <linux-s390@archiver.kernel.org>; Mon, 31 May 2021 14:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhEaONP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 May 2021 10:13:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44628 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231436AbhEaOLM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 May 2021 10:11:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VE2ijH083517;
        Mon, 31 May 2021 10:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=T4Mia/ZNkulYyoqr6of2Q/rtb/T9nLxZPVbSkDMgMRU=;
 b=k77lOC9xKYrklOAmn20p/guGuAlIwnhcBdf3ypqbiPz6Wf6wOTSyLLTqGyYi3ITEKY/V
 LUdHkVqMW/EU+agnpAG29aje+sOY9IPqMjQ8HbXaYUJMs7Pd/ar++Dps9/TDDn/4suIe
 l8F12Pza/iAJid+2QGKLEylr94jNBYpJr+0K/Q9RAnR546/soM9cvcrV3L3UnkcQrujG
 /kKZHzQm3SIolpdrnhbhgkA3Qeu3cOn1tLrfVVsfBnrv/D2Mxm+hDcf5rI0MWgTM3/9c
 P+oNNo1UPuxq5usOTmxysiXfxI32UgnPKFi+SC8aYbqUGYq4EOhfHykPUOv+IisVe3dK HQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38vy10uud9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 10:09:26 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14VE2WA7005345;
        Mon, 31 May 2021 14:09:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvh932g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 14:09:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14VE8pFI18547052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 14:08:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34E28AE055;
        Mon, 31 May 2021 14:09:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8765AE04D;
        Mon, 31 May 2021 14:09:21 +0000 (GMT)
Received: from localhost (unknown [9.171.73.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 31 May 2021 14:09:21 +0000 (GMT)
Date:   Mon, 31 May 2021 16:09:20 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] S390: appldata depends on PROC_SYSCTL
Message-ID: <your-ad-here.call-01622470160-ext-4376@work.hours>
References: <20210528002420.17634-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210528002420.17634-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dqbOenQtIXFTSjACgDKKT_wOLNSBRNzd
X-Proofpoint-GUID: dqbOenQtIXFTSjACgDKKT_wOLNSBRNzd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_08:2021-05-31,2021-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=753 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105310101
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 27, 2021 at 05:24:20PM -0700, Randy Dunlap wrote:
> APPLDATA_BASE should depend on PROC_SYSCTL instead of PROC_FS.
> Building with PROC_FS but not PROC_SYSCTL causes a build error,
> since appldata_base.c uses data and APIs from fs/proc/proc_sysctl.c.
> 
> arch/s390/appldata/appldata_base.o: in function `appldata_generic_handler':
> appldata_base.c:(.text+0x192): undefined reference to `sysctl_vals'
> 
> Fixes: c185b783b099 ("[S390] Remove config options.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210526.orig/arch/s390/Kconfig
> +++ linux-next-20210526/arch/s390/Kconfig
> @@ -853,7 +853,7 @@ config CMM_IUCV
>  config APPLDATA_BASE
>  	def_bool n
>  	prompt "Linux - VM Monitor Stream, base infrastructure"
> -	depends on PROC_FS
> +	depends on PROC_SYSCTL
>  	help
>  	  This provides a kernel interface for creating and updating z/VM APPLDATA
>  	  monitor records. The monitor records are updated at certain time

Applied, thanks
