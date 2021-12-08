Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCAC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 15:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhLHPlP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:41:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230518AbhLHPlO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 10:41:14 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8ENAPh017369
        for <linux-s390@vger.kernel.org>; Wed, 8 Dec 2021 15:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sk/veqp9luOAaekfpWL9Rl2tXosGtBzgaWFdc2qCjnQ=;
 b=iaVK6OHjozVg6Ly2yU5veK2UCXLbjOwpx2IjOPRhVVbdETu2sWOqy4PQG9toHtZS4cIm
 vkpGsbgSAkFjJL09mJ+VJQT9YW9Tzcuf88xyafeMqR7c5SYwEpdFJ9GaGc6S+HpyK8kK
 lF7Cc/Ra6eEcIgvHtQLjvJlBzvNtkAXTaMd/GIXUqQarTcDcWJ2USzt4MFiADMDUpQRw
 NBgma5edlbRo6eywqeJUdDOiwfUXj2RhdLFrcJ3Qj1YV3l0smuOMLl2KME1rOagLmVv6
 GeurV4cm11+KE1BJyQavGoCzdmfH+nC4f7BPsrqGWWrN51fkq7nPwmpp6e6B98Zbv90v 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctxdyhnpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 08 Dec 2021 15:37:42 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8FTFZ0015954
        for <linux-s390@vger.kernel.org>; Wed, 8 Dec 2021 15:37:41 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ctxdyhnp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:37:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8FBsSw026658;
        Wed, 8 Dec 2021 15:37:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3cqyya9d8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 15:37:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8Fbbx722479126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 15:37:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EAC742042;
        Wed,  8 Dec 2021 15:37:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 447014203F;
        Wed,  8 Dec 2021 15:37:37 +0000 (GMT)
Received: from osiris (unknown [9.145.37.164])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Dec 2021 15:37:37 +0000 (GMT)
Date:   Wed, 8 Dec 2021 16:37:35 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     linux-s390@vger.kernel.org, egorenar@linux.ibm.com, ltao@redhat.com
Subject: Re: [PATCH v3 0/2] s390/kexec_file: improve error handling and
 messages
Message-ID: <YbDRP1G2S0hbvoK4@osiris>
References: <20211208130741.5821-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208130741.5821-1-prudo@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0AEGAe45NoxLGpmiXF2maPJpYyfkQZyL
X-Proofpoint-ORIG-GUID: AU_vRb2YZtIUbCHlSsHyJ2waUN_lb-Ok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_06,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=711 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Dec 08, 2021 at 02:07:39PM +0100, Philipp Rudo wrote:
> Hi everybody,
> 
> here is v3.
> 
> @Heiko: I hope you are happy now.

Yes, very happy!

> v3:
> 	- add the symbol name to the error messages
> 
> v2:
> 	- EINVAL -> ENOEXEC
> 	- print error message when encountering an unknown relocation
> 	- new patch to print error messages for all error cases in the function
> 
> Philipp Rudo (2):
>   s390/kexec_file: print some more error messages
>   s390/kexec_file: fix error handling when applying relocations
> 
>  arch/s390/kernel/machine_kexec_file.c | 34 +++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)

Applied both. Thank you!
