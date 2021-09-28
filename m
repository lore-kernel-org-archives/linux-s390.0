Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B0C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC019611BD
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 08:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbhI1Iep (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:34:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239549AbhI1Ieo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Sep 2021 04:34:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S7ldmW020770;
        Tue, 28 Sep 2021 04:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=QEXlZMIC6iM1yz4vT8O7ipT4CKWuXJp53oPJPNaf50E=;
 b=pfSC0LW5sz1c/YbfXQU2pvQDh9XbiBfwOOJ0bq4D7+CTOyr1iX79zahWtWWCziM2T73J
 GVuaTDscvq4QDJgcnw6JVVYRZPzoLr8vfe6ceJVRMzm2oL8BUh5lPTFOApV/GA2FbvDE
 /0ycT8CjlOgkbfo7HBca9xuc/dfvo3vLI8A/wl0Ip5nGq1lTW9/tZ8k2Fl9Q4AT/F5wo
 ilug3AskQF0fxFEhB74OYpufz7LTck4WZIon/YaGxoePSmQk6QfiI6xl0yGDamTTvTmt
 le+gUMrCwJSIExv1kQVLV4ix+DjtXOcNYdlMxTqHcRBNxs9QsA4SdTqUSA9XGshIYEzZ ug== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bbxyfgx0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 04:33:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18S8RqqU015125;
        Tue, 28 Sep 2021 08:32:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9ud9uj30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 08:32:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18S8RrqM55640410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 08:27:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C78E3AE067;
        Tue, 28 Sep 2021 08:32:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83D0EAE058;
        Tue, 28 Sep 2021 08:32:52 +0000 (GMT)
Received: from osiris (unknown [9.145.163.77])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Sep 2021 08:32:52 +0000 (GMT)
Date:   Tue, 28 Sep 2021 10:32:51 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/sclp_vt220: fix unused function warning
Message-ID: <YVLTM38zdOZJKdmI@osiris>
References: <20210927215647.11506-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927215647.11506-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -UkWfGIifByPnIyC8awmE9iUr5LCyyeR
X-Proofpoint-ORIG-GUID: -UkWfGIifByPnIyC8awmE9iUr5LCyyeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_04,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280050
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 27, 2021 at 02:56:47PM -0700, Randy Dunlap wrote:
> When CONFIG_SCLP_VT220_TTY=y and CONFIG_SCLP_VT220_CONSOLE is not set:
> 
> ../drivers/s390/char/sclp_vt220.c:771:13: warning: '__sclp_vt220_flush_buffer' defined but not used [-Wunused-function]
>   771 | static void __sclp_vt220_flush_buffer(void)
> 
> so move this function inside the #ifdef block where it is used.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
> Sorry, I can't determine what the Fixes: tag for this should be
> (missing some git fu).

It's not worth spending time to figure this out.

Applied, thanks!
