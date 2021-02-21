Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4860C433E0
	for <linux-s390@archiver.kernel.org>; Sun, 21 Feb 2021 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0F3614A7
	for <linux-s390@archiver.kernel.org>; Sun, 21 Feb 2021 19:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBUTHr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 21 Feb 2021 14:07:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230199AbhBUTHh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 21 Feb 2021 14:07:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11LJ4ADH149100;
        Sun, 21 Feb 2021 14:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BT/jAItixC61r62lBhr5LEawjoT7iThqpRO78aFCo9A=;
 b=rUQbSRrOw5876Tv445fhonYmIR4v75q/vWAQf3dte8M3PjVjV3L8PwsMLhZOVA4FFD2V
 8MnC9I+EXyqruiO184q5Lt/Ct7g5myzgE/D05wQvwQtnlK4l8ukrLz7TJ+s9jr6o4vfS
 oSzzawxIs07i6vgNtbEBT9VkLNol6pJbnF+S7ItzYiGSjcbLDLMI3R+XNhw3SoNe5SSF
 qaKKDu+NJpP/ghZ6j2U6aa4392A5D5KhA9EhyeaGfPmw2EP+DRv95I1qqMz9CWKTOfyr
 tyydNbZIeFhE0KQ7jHByreAcpBfyYLFGFd7n3Tj+gagPpcpL3XuZIE8nogDtHZ70pzHr 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36uwa90570-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 14:06:44 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11LJ4FPF149656;
        Sun, 21 Feb 2021 14:06:36 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36uwa904q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 14:06:36 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11LJ3NLW010289;
        Sun, 21 Feb 2021 19:06:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 36tt288h83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 19:06:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11LJ6ChP36634954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 19:06:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F97D42041;
        Sun, 21 Feb 2021 19:06:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F005942042;
        Sun, 21 Feb 2021 19:06:23 +0000 (GMT)
Received: from osiris (unknown [9.171.64.199])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 21 Feb 2021 19:06:23 +0000 (GMT)
Date:   Sun, 21 Feb 2021 20:06:22 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: use ARRAY_SIZE instead of division operation
Message-ID: <YDKvLurzMw1NO4JN@osiris>
References: <1613809357-89354-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613809357-89354-1-git-send-email-yang.lee@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_10:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102210195
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Feb 20, 2021 at 04:22:37PM +0800, Yang Li wrote:
> This eliminates the following coccicheck warning:
> ./arch/s390/tools/gen_facilities.c:154:37-38: WARNING: Use ARRAY_SIZE
> ./arch/s390/tools/gen_opcode_table.c:141:39-40: WARNING: Use ARRAY_SIZE
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/s390/tools/gen_facilities.c   | 2 +-
>  arch/s390/tools/gen_opcode_table.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 61ce5b5..5366817 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -151,7 +151,7 @@ static void print_facility_lists(void)
>  {
>  	unsigned int i;
>  
> -	for (i = 0; i < sizeof(facility_defs) / sizeof(facility_defs[0]); i++)
> +	for (i = 0; i < ARRAY_SIZE(facility_defs); i++)
>  		print_facility_list(&facility_defs[i]);
>  }
>  
> diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
> index a1bc02b..468b70c 100644
> --- a/arch/s390/tools/gen_opcode_table.c
> +++ b/arch/s390/tools/gen_opcode_table.c
> @@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
>  	strcpy(tmp, format);
>  	base_format = tmp;
>  	base_format = strsep(&base_format, "_");
> -	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
> +	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {

There is a reason why this doesn't use ARRAY_SIZE()...
Please stop sending trivial patches without even looking at the code.
