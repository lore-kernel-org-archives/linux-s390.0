Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E6C4332F
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E8161528
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhJELPX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 07:15:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234165AbhJELPW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 07:15:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195A1XYJ029266;
        Tue, 5 Oct 2021 07:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SOXWXcwMIz8uBqfL4uXH929m8bQsgVNK65Ah6LpznGQ=;
 b=OIKqNZk0wkSh5HhidfqCK13cQzLMFNTWv2TOyUV9C1pW7lTvwzFrver6cGA6sFOycDeH
 fgtKQfol11MHusUCHKeLDd/1OKbuX9QU4wFCFH5lnx9D9XM1fRghIL1LgNR9lSj/VaUn
 ixms0lcUSBTluQZDPwbvWiYQxCOfNULfzHysoVGh1HHX0/kfPkhEEIjGTHLTn/iOJibl
 aULu2hNeQcwj3ZfoLjKiAv+bvBAaownu/pd89bFwA/n/x7V9t7ZlDyxUyVBYja5ApozP
 M812RAYXZg0F1706U638VIoHi2QWOxGaBUX8PETWYkGwaedpoHG1mx3tEMt2hon21++T BQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgmkeshfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 07:13:29 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 195BD0Sj003217;
        Tue, 5 Oct 2021 11:13:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3beepjfevq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 11:13:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 195B86r243057486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 11:08:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F38F42041;
        Tue,  5 Oct 2021 11:13:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E8CE42042;
        Tue,  5 Oct 2021 11:13:23 +0000 (GMT)
Received: from osiris (unknown [9.145.46.219])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Oct 2021 11:13:23 +0000 (GMT)
Date:   Tue, 5 Oct 2021 13:13:21 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Fix strrchr() implementation
Message-ID: <YVwzUbHcZkHQT0K4@osiris>
References: <20211005072621.53500-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005072621.53500-1-roberto.sassu@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8w7pAMI7f5L0qqi08dJmVxy8k8iKjIwo
X-Proofpoint-ORIG-GUID: 8w7pAMI7f5L0qqi08dJmVxy8k8iKjIwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=946 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05, 2021 at 09:26:21AM +0200, Roberto Sassu wrote:
> Access the string at len - 1 instead of len.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  arch/s390/lib/string.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
> index cfcdf76d6a95..162a391788ad 100644
> --- a/arch/s390/lib/string.c
> +++ b/arch/s390/lib/string.c
> @@ -261,12 +261,12 @@ char *strrchr(const char *s, int c)
>  {
>         size_t len = __strend(s) - s;
>  
> -       if (len)
> -	       do {
> -		       if (s[len] == (char) c)
> -			       return (char *) s + len;
> -	       } while (--len > 0);
> -       return NULL;
> +	if (len)
> +		do {
> +			if (s[len - 1] == (char) c)
> +				return (char *) s + len - 1;
> +		} while (--len > 0);
> +	return NULL;

You missed to tell what this is supposed to fix. The patch however is
incorrect: the terminating null byte is considered part of the
string. With your patch strrchr(somestring, 0) would not work
correctly anymore.

However our strrchr implementation is indeed broken, since for an
empty string and searching for the null byte would incorrectly return
NULL. Luckily there is not a single invocation in the kernel which
doing that.
