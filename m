Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F74DC433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000C560F5B
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 20:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhJDUdq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 16:33:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46554 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233934AbhJDUdp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 16:33:45 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194K27hl002892;
        Mon, 4 Oct 2021 16:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YSKuInWCPUB4cRcl9zVFp9tJjrcN0o3rJYA57zQkw9Y=;
 b=jwQP6WwQs5/IHcOpT6T6FNiZtkwDaelmqrYi5iR/Qxu2CnNjGuPdp3FAM8/Ee1uxngtU
 0c+qV8HmJgLf0I9NxYsAXNpX4e79LKFuPje8N3RWB5ejDdOVYoRHUl16KOKIbBO8/OLo
 FnHRlJ7o+UxR5DNbKQuhQURqLRpUmGnJ5WyVUhOJE7R8HFPzW6qNKmlCaR+3b1nMn679
 h1js+OnyXhNN7qIYmTGhFJzzT8wfdJqcgzVQ0VVZj+QUbuMmdBy0QorrjhgxeUqxO3N+
 oIdScdM4iLzh/z9KvEzUNatqTFgrBTiFo2lyTHutWXo04CC1tLo+pBTjNxrAtoWYHCLC NA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bg89y8gfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 16:31:54 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194KSWAe014348;
        Mon, 4 Oct 2021 20:31:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3bef29sp3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 20:31:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194KVmmt64553404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 20:31:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FDC9A4060;
        Mon,  4 Oct 2021 20:31:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59C78A405C;
        Mon,  4 Oct 2021 20:31:48 +0000 (GMT)
Received: from osiris (unknown [9.145.70.99])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  4 Oct 2021 20:31:48 +0000 (GMT)
Date:   Mon, 4 Oct 2021 22:31:46 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Message-ID: <YVtksmjj1eGqw5GY@osiris>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SYvjJX6cks5LzrErIhpAa5Ruz3EB_7-2
X-Proofpoint-GUID: SYvjJX6cks5LzrErIhpAa5Ruz3EB_7-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040138
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 01, 2021 at 04:02:01PM +0300, Andy Shevchenko wrote:
> Use string_upper() from string helper module instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/s390/mm/cmm.c    | 11 ++++-------
>  arch/s390/mm/extmem.c | 21 ++++++++++++---------
>  2 files changed, 16 insertions(+), 16 deletions(-)
...
>  static void
>  dcss_mkname(char *name, char *dcss_name)
>  {
> +	/* Segment name is limited by 8 characters + NUL */
> +	char tmp[8 + 1];
>  	int i;
>  
> -	for (i = 0; i < 8; i++) {
> -		if (name[i] == '\0')
> -			break;
> -		dcss_name[i] = toupper(name[i]);
> -	}
> -	for (; i < 8; i++)
> -		dcss_name[i] = ' ';
> +	/*
> +	 * This snprintf() call does two things:
> +	 * - makes a NUL-terminated copy of the input string
> +	 * - pads it with spaces
> +	 */
> +	snprintf(tmp, sizeof(tmp), "%s        ", name);

I can't say I like code where I have to count spaces in order to
verify if the code is actually correct.

> +	string_upper(dcss_name, tmp);
...
>  static struct dcss_segment *
>  segment_by_name (char *name)
>  {
> -	char dcss_name[9];
> +	char dcss_name[8];

string_upper will copy the terminating NUL-byte. By reducing the size
of dcss_name to 8 bytes this will result in stack corruption.
