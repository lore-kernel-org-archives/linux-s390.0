Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012CDC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD04A61A38
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhKPLUk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:20:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230255AbhKPLUj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Nov 2021 06:20:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGBCIE3007116;
        Tue, 16 Nov 2021 11:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=5jYOq40KWOJHt6cqZ20iXA+Pkn3yFESAgK1X2uRdGlU=;
 b=mlGeL/cS8vBrwpr6LC6jYJkogMdO8zrhM8UEF02q5zBMAez/Y9xDOLdCh2ewo2C9u/p2
 YInis/iSXg2zYOUJVjef1jB3Mm9QEdmd08xuK73IINwv9N3xkTvCLcD9WNUjl/qkHCt6
 1ZEWYBt277xoZW7ncUqFeo9EqNr7qVSifcNh6e55E7aAvzWD0xAfvnT0I4IlD3XTs0fV
 l8RAjefW3cRWE+WITN/SkCZtf4fBdKeuwqscGzZuyMhvKCyULac8qFszZfd40z+aL0II
 1UXxaJ+LD2tSoI2txinzYVAkgeFLKwHun67Y0wc0uXEAkKTbROMSpKmSOk7nVqFhWrIT EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ccbjh83e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 11:17:37 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AGBCo4G008336;
        Tue, 16 Nov 2021 11:17:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ccbjh83dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 11:17:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AGBH7nn020600;
        Tue, 16 Nov 2021 11:17:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca509xkms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 11:17:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AGBHHfg56492428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 11:17:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85A30A4066;
        Tue, 16 Nov 2021 11:17:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42712A405F;
        Tue, 16 Nov 2021 11:17:17 +0000 (GMT)
Received: from osiris (unknown [9.145.93.200])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Nov 2021 11:17:17 +0000 (GMT)
Date:   Tue, 16 Nov 2021 12:17:15 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, prudo@redhat.com
Subject: Re: [PATCH v2 1/2] s390/kexec: check the return value of
 ipl_report_finish
Message-ID: <YZOTO+37BbIwOpUK@osiris>
References: <20211116032557.14075-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211116032557.14075-1-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2pBshsDu0wpiPGtKezHwemDgIXks_JSb
X-Proofpoint-GUID: yOYuWIN_EIQff3CkM6L9D6avyOG47rCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_01,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160056
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 16, 2021 at 11:25:56AM +0800, Baoquan He wrote:
> In function ipl_report_finish(), it could fail by memory allocation
> failure, so check the return value to handle the case.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/s390/include/asm/ipl.h           | 2 +-
>  arch/s390/kernel/ipl.c                | 6 ++++--
>  arch/s390/kernel/machine_kexec_file.c | 5 ++++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
> index 3f8ee257f9aa..864ab5d2890c 100644
> --- a/arch/s390/include/asm/ipl.h
> +++ b/arch/s390/include/asm/ipl.h
> @@ -122,7 +122,7 @@ struct ipl_report_certificate {
>  
>  struct kexec_buf;
>  struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib);
> -void *ipl_report_finish(struct ipl_report *report);
> +int ipl_report_finish(struct ipl_report *report, void **ipl_buf);
>  int ipl_report_free(struct ipl_report *report);
>  int ipl_report_add_component(struct ipl_report *report, struct kexec_buf *kbuf,
>  			     unsigned char flags, unsigned short cert);
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index e2cc35775b99..a0af0b23148d 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -2144,7 +2144,7 @@ struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib)
>  	return report;
>  }
>  
> -void *ipl_report_finish(struct ipl_report *report)
> +int ipl_report_finish(struct ipl_report *report, void **ipl_buf)
>  {
>  	struct ipl_report_certificate *cert;
>  	struct ipl_report_component *comp;
> @@ -2195,7 +2195,9 @@ void *ipl_report_finish(struct ipl_report *report)
>  	}
>  
>  	BUG_ON(ptr > buf + report->size);
> -	return buf;
> +	*ipl_buf = buf;
> +
> +	return 0;

This does not compile:

  CC      arch/s390/kernel/ipl.o
arch/s390/kernel/ipl.c: In function ‘ipl_report_finish’:
arch/s390/kernel/ipl.c:2159:24: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
 2159 |                 return ERR_PTR(-ENOMEM);
      |                        ^~~~~~~~~~~~~~~~

Anyway, before we are going to have more iterations I just applied the
patch below instead before applying your memory leak fix.

From 78e5f268d1be775354ab83c1e039dcfacaa5e258 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Tue, 16 Nov 2021 11:06:38 +0100
Subject: s390/kexec: fix return code handling

kexec_file_add_ipl_report ignores that ipl_report_finish may fail and
can return an error pointer instead of a valid pointer.
Fix this and simplify by returning NULL in case of an error and let
the only caller handle this case.

Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to next kernel")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/ipl.c                | 3 ++-
 arch/s390/kernel/machine_kexec_file.c | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index e2cc35775b99..5ad1dde23dc5 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2156,7 +2156,7 @@ void *ipl_report_finish(struct ipl_report *report)
 
 	buf = vzalloc(report->size);
 	if (!buf)
-		return ERR_PTR(-ENOMEM);
+		goto out;
 	ptr = buf;
 
 	memcpy(ptr, report->ipib, report->ipib->hdr.len);
@@ -2195,6 +2195,7 @@ void *ipl_report_finish(struct ipl_report *report)
 	}
 
 	BUG_ON(ptr > buf + report->size);
+out:
 	return buf;
 }
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 528edff085d9..f0200b503f94 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -170,6 +170,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 	struct kexec_buf buf;
 	unsigned long addr;
 	void *ptr, *end;
+	int ret;
 
 	buf.image = image;
 
@@ -199,7 +200,10 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		ptr += len;
 	}
 
+	ret = -ENOMEM;
 	buf.buffer = ipl_report_finish(data->report);
+	if (!buf.buffer)
+		goto out;
 	buf.bufsz = data->report->size;
 	buf.memsz = buf.bufsz;
 
@@ -209,7 +213,9 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		data->kernel_buf + offsetof(struct lowcore, ipl_parmblock_ptr);
 	*lc_ipl_parmblock_ptr = (__u32)buf.mem;
 
-	return kexec_add_buffer(&buf);
+	ret = kexec_add_buffer(&buf);
+out:
+	return ret;
 }
 
 void *kexec_file_add_components(struct kimage *image,
-- 
2.31.1
