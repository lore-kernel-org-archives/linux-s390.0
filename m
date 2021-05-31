Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB001C47082
	for <linux-s390@archiver.kernel.org>; Mon, 31 May 2021 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856B61287
	for <linux-s390@archiver.kernel.org>; Mon, 31 May 2021 21:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhEaV5L (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 May 2021 17:57:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231240AbhEaV5K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 May 2021 17:57:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VLhRJ8028501;
        Mon, 31 May 2021 17:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=6ga0okV+GzQJQdPaMW2IItWnEY6HUhXAuL1mWYBLAwM=;
 b=IT+soXpy9Hp4VitACREy4cBgofgvhsWYaV+iVbxz3PzmUoH9WQf7nVyGTsdriv5URN4n
 jadtw4gJOyKR2prUI2DUf/TAnZ7zD8rrKA5sBHV/1LeX+CchVP7l45NZ5qlqEQwUwpv2
 uYuWLKY9lUtBsL4woMd+0Ul9a97a6VWNOIU6KdEgc+o+uIOq+mWeDW8ZMJT2Hq4Q0ovC
 6GVRHvnuZSkV7xclnQ6OMtcZ3A5Fkku/72Oz/fEp+oOoRpI4eObQgivW790nELE82X6T
 v4P3WMu9/Xm32f35xG+FjQO1KOilUi/AGpnybIIKhhM/5Y55MBO8w3pEEdJuAlD68+iV OA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38w7ybg65k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 17:55:28 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14VLtQoT009383;
        Mon, 31 May 2021 21:55:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 38ud888p8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 21:55:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14VLtNd434079074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 21:55:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DE63AE051;
        Mon, 31 May 2021 21:55:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F235AAE04D;
        Mon, 31 May 2021 21:55:22 +0000 (GMT)
Received: from localhost (unknown [9.171.3.22])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 31 May 2021 21:55:22 +0000 (GMT)
Date:   Mon, 31 May 2021 23:55:21 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Rob Landley <rob@landley.net>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace use of perl with sed and tr in s390x build.
Message-ID: <your-ad-here.call-01622498121-ext-5758@work.hours>
References: <a48c51f8-5fe4-87e7-284e-c96e2381801a@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a48c51f8-5fe4-87e7-284e-c96e2381801a@landley.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kFhzGz_GNpo1T4mShkQSIBh9OmbGtfYb
X-Proofpoint-ORIG-GUID: kFhzGz_GNpo1T4mShkQSIBh9OmbGtfYb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_15:2021-05-31,2021-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105310162
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 17, 2021 at 11:46:44PM -0500, Rob Landley wrote:
> From: Rob Landley <rob@landley.net>
> 
> Commit 246218962e21 in November added a perl dependency to the s390x vmlinux
> build, complicating the "countering trusting trust" build approach ala
> http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
> 
>  arch/s390/boot/compressed/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
> index de18dab518bb..e941b165bd4f 100644
> --- a/arch/s390/boot/compressed/Makefile
> +++ b/arch/s390/boot/compressed/Makefile
> @@ -33,7 +33,7 @@ $(obj)/vmlinux.syms: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OB
>  
>  quiet_cmd_dumpsyms = DUMPSYMS $<
>  define cmd_dumpsyms
> -	$(NM) -n -S --format=bsd "$<" | $(PERL) -ne '/(\w+)\s+(\w+)\s+[tT]\s+(\w+)/ and printf "%x %x %s\0",hex $$1,hex $$2,$$3' > "$@"
> +	$(NM) -n -S --format=bsd "$<" | sed -nE 's/^0*([0-9a-fA-F]+) 0*([0-9a-fA-F]+) [tT] ([^ ]*)$$/\1 \2 \3/p' | tr '\n' '\0' > "$@"
>  endef

The change itself is fine. Yields the same result as before with
binutils/llvm/elfutils versions of nm.

With s390 defconfig there is at least another perl invocation via
./lib/build_OID_registry, which is hard to get rid of. debug_defconfig calls
./scripts/headers_check.pl on top. Perl is explicitly listed in "Minimal
requirements to compile the Kernel" in Documentation/process/changes.rst and
quite frankly I'm not aware of any plans to get rid of it. It has its use.

So, would you mind if I pick your patch changing the commit message
like the following?
"""
s390/decompressor: replace use of perl with simple sed/tr

Use simple sed/tr instead of perl to generate decompressor symbols
file with the same result.

Signed-off-by: Rob Landley <rob@landley.net>
"""
