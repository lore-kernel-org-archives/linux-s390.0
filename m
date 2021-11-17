Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D07C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 09:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33267611ED
	for <linux-s390@archiver.kernel.org>; Wed, 17 Nov 2021 09:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhKQJQq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:16:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30678 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234864AbhKQJQq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Nov 2021 04:16:46 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH8VVb9005900;
        Wed, 17 Nov 2021 09:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XrJAd1Pc49/Lad5PPGd9f+XWGaw1OjLz1leQG8ywM9Q=;
 b=OfnK771qeIQINL/6wd7vJGqOW1NcnkMoiweohV3OyAadYiTFyQIGWUWngpAt0ZPRGme+
 j9ZBBqZ7WlMRo/SO/MD/M1t4sDOjTBfrLZWzPyX0ro/PE219jod70mrjnVwhhqxswquf
 CH9/2E4iQn0K+1yuqMOU5bG1AFR+jcX9VyN2ObJXVT5DAj1o5DTT9bI4KwlYXq2CGBum
 TYVEH9ptx2yQh7RpWd7cwAF/Q+MJWuE531+b5M0Ke6d765boHoEOi0vQYuc7k7/xZbml
 /ocgfzkI3NOI1nqtk9Q8SagdG0H5Hgm/m7Lm5OetBkDEoISGrPhc7ZRHyPoHyLVanzhl Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccxa3rq7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:13:31 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AH99oFW016306;
        Wed, 17 Nov 2021 09:13:30 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccxa3rq7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:13:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AH9DAAR014194;
        Wed, 17 Nov 2021 09:13:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mjywds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 09:13:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AH9DQ4q2818716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 09:13:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D79DA4080;
        Wed, 17 Nov 2021 09:13:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 327D1A406D;
        Wed, 17 Nov 2021 09:13:26 +0000 (GMT)
Received: from osiris (unknown [9.145.92.52])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Nov 2021 09:13:26 +0000 (GMT)
Date:   Wed, 17 Nov 2021 10:13:24 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/2] ftrace/samples: fix ftrace direct multi config
 option + s390 support
Message-ID: <YZTHtFCam6V8bJ4D@osiris>
References: <20211115195614.3173346-1-hca@linux.ibm.com>
 <20211116174533.28f4b8ea@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116174533.28f4b8ea@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4VW95jkOUvKOme20ls250iYDLg7XX82A
X-Proofpoint-GUID: UrDTqA45PgUEw-3lr7OcLPY9Cjh_yQdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170045
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 16, 2021 at 05:45:33PM -0500, Steven Rostedt wrote:
> > two patches for ftrace direct multi sample:
> > 
> > - fix ftrace direct multi sample config option handling, required
> >   because of an incorrect merge resolution proposed by me.
> > 
> > - add s390 support for ftrace direct multi sample
> > 
> > If you are happy with them, I could carry with the s390 tree and
> > target for rc2, or you could pick them up. Whatever you prefer.
> 
> I'm good with you taking them through your tree. I acked the first patch as
> it touches my code. And the second belongs to you anyway, but I would still
> ask you to add some description to the change log.

Will do, and I'll add to the s390 tree.

Thanks!
