Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD14C433E6
	for <linux-s390@archiver.kernel.org>; Mon, 22 Feb 2021 16:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2244164E61
	for <linux-s390@archiver.kernel.org>; Mon, 22 Feb 2021 16:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhBVQKm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:10:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55642 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231735AbhBVQKh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Feb 2021 11:10:37 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MG7KcC093869;
        Mon, 22 Feb 2021 11:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to : sender; s=pp1;
 bh=e10sRKXrRQP/yyKgNz/7fjY2pJYcOYdrb1QU5xWU+X8=;
 b=AWekrGFUH8yq/xRHBanJ81XgiKOGe8NYXEaf+zqaZ1cFsDTYPqCs5S39EWaJWAdBKC9/
 hlhcc51lsIf38Qp5rSUlQIVD1F3j43vKp7ohzX5R3kQHztAFqWEGg+kp2umlZ/WT+yeI
 7HDjsRvlr3Hk94AaeTH4UjCtUWcezsXNUwY7MczAz9lpcD6U/PFeUZ1mA9I4sjwm/imE
 XFBMlqNucHdOpFk+WgR1Ughlxnue8nCrME6U7V0BCu+aTqX/Ls8QdTF9NbbUzSfQL/fq
 GSMixXvQ95h4XWm5NlQip1ojxXgrfz6y15OrIPlToiPsMG8sOEtVrQIsSD/rsWNGCIKI CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vfsq89ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 11:09:29 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MG893V113711;
        Mon, 22 Feb 2021 11:08:42 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vfsq87fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 11:08:17 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MG4Xo0031127;
        Mon, 22 Feb 2021 16:04:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 36tt288xgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:04:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MG4Ike37618064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 16:04:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 788DF4C04A;
        Mon, 22 Feb 2021 16:04:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 667864C046;
        Mon, 22 Feb 2021 16:04:30 +0000 (GMT)
Received: from t480-pf1aa2c2.fritz.box (unknown [9.145.72.151])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 22 Feb 2021 16:04:30 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2.fritz.box with local (Exim 4.94)
        (envelope-from <bblock@linux.ibm.com>)
        id 1lEDhF-0009vS-Qf; Mon, 22 Feb 2021 17:04:29 +0100
Date:   Mon, 22 Feb 2021 17:04:29 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Steffen Maier <maier@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/20] scsi: zfcp: Manual replacement of the deprecated
 strlcpy() with return values
Message-ID: <YDPWDU7iVTY7aY2h@t480-pf1aa2c2.linux.ibm.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <20210222151231.22572-14-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222151231.22572-14-romain.perier@gmail.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_03:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220147
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 22, 2021 at 04:12:24PM +0100, Romain Perier wrote:
> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.
> It can lead to linear read overflows, crashes, etc...
> 
> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
> 
> This commit replaces all calls to strlcpy that handle the return values
> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  drivers/s390/scsi/zfcp_fc.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
> index d24cafe02708..8a65241011b9 100644
> --- a/drivers/s390/scsi/zfcp_fc.c
> +++ b/drivers/s390/scsi/zfcp_fc.c
> @@ -877,14 +877,16 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
>  	struct zfcp_fsf_ct_els *ct_els = &fc_req->ct_els;
>  	struct zfcp_fc_rspn_req *rspn_req = &fc_req->u.rspn.req;
>  	struct fc_ct_hdr *rspn_rsp = &fc_req->u.rspn.rsp;
> -	int ret, len;
> +	int ret;
> +	ssize_t len;
>  
>  	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
>  			   FC_SYMBOLIC_NAME_SIZE);
>  	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
> -	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
> +	len = strscpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
>  		      FC_SYMBOLIC_NAME_SIZE);
> -	rspn_req->rspn.fr_name_len = len;
> +	if (len != -E2BIG)
> +		rspn_req->rspn.fr_name_len = len;

That is a bug. Leaving `rspn.fr_name_len` uninitialized defeats the
purpose of sending a RSPN.

How about:
	if (len == -E2BIG)
		rspn_req->rspn.fr_name_len = FC_SYMBOLIC_NAME_SIZE - 1;
	else
		rspn_req->rspn.fr_name_len = len;

>  
>  	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));
>  	sg_init_one(&fc_req->sg_rsp, rspn_rsp, sizeof(*rspn_rsp));
> 

-- 
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Systems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/privacy
Vorsitz. AufsR.: Gregor Pillen         /        Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294
