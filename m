Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A9EC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0AB9611C6
	for <linux-s390@archiver.kernel.org>; Wed, 15 Sep 2021 15:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhIOPPK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Sep 2021 11:15:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55734 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238064AbhIOPPH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Sep 2021 11:15:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18FEWVgm007862;
        Wed, 15 Sep 2021 11:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TweV0ObwXVO+zHibZFEyWufzhhgQYs0SGA5CXvY/FgA=;
 b=iraN+uXB6CRpWl7EhMjd8+prqfW96zEMLuz5niM8pnJ3YCQM3sI+txyexpH9zdqgYsfa
 Rn/6PinAuf0jo3arGVNgO09DFmc2Xd+pb+i4pQKljcxO40ojt60g3/pHBRWpLkwKrWF7
 LlyF+8iooaADnKv1owAqsAoPT8VVxLG0j4oCBnLr5l7jZ9/Coi/DBJtzRdZg3XfOhoWk
 nvoqo7xRs3UytKo69iNqlQR+x0IATWphxF50NP/VE0EiUBZ/ANx3uBP+cg9iz15+LKZP
 yio1U6IpFbOIh28K0UN/J0ytJtZntVvkbqpLpTfs0ozDasFI04aIm8W6d/wlL8Wiq8J/ /g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b3gwecmeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 11:13:36 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18FFCvnh004002;
        Wed, 15 Sep 2021 15:13:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3b0m3a77nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 15:13:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18FF8u8S57540954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 15:08:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C084A405C;
        Wed, 15 Sep 2021 15:13:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE5E1A4060;
        Wed, 15 Sep 2021 15:13:29 +0000 (GMT)
Received: from localhost (unknown [9.171.18.94])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Sep 2021 15:13:29 +0000 (GMT)
Date:   Wed, 15 Sep 2021 17:13:28 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Add WARN_DYNAMIC_STACK dependencies
Message-ID: <your-ad-here.call-01631718808-ext-1439@work.hours>
References: <20210915044010.640499-1-linux@roeck-us.net>
 <80b7dbc9-0c09-197f-0f40-ab92d2e3fe3c@de.ibm.com>
 <84949d48-435a-e76b-9977-d072f7359d91@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84949d48-435a-e76b-9977-d072f7359d91@roeck-us.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sCEnG9ADulu-mYJeTKvoTLvL5wRMiSu6
X-Proofpoint-ORIG-GUID: sCEnG9ADulu-mYJeTKvoTLvL5wRMiSu6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150073
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 15, 2021 at 07:08:21AM -0700, Guenter Roeck wrote:
> > Thanks for the patch. I think Heiko (on vacation) has a patch to
> > get rid  of this config alltogether, which is probably the better
> > solution.
> > 
> 
> I did consider that, but concluded that this would be something a maintainer
> should do and went with what I thought was the least invasive method.
> I did check the various mailing lists for other patches, but I did not
> find anything there. Sorry if I missed it.

Sorry, we could have been more transparent with our patch queue. The
patch is from Monday and with our regular ci/qa queue delay it is now on
fixes branch:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=fixes&id=f5711f9df9242446feccf2bdb6fdc06a72ca1010
