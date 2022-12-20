Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3338C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 20 Dec 2022 15:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiLTPoc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiLTPoP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Dec 2022 10:44:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6174518358
        for <linux-s390@vger.kernel.org>; Tue, 20 Dec 2022 07:44:13 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKFg5UM016742
        for <linux-s390@vger.kernel.org>; Tue, 20 Dec 2022 15:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=G7hzihla+TaYA4Z0LIAYhwbXJO1D6Q3V12GZkInqOyE=;
 b=bJaDjBQqF17eKi/2MBm3UcD9Ru3lvRLT/9pG8L3rf5ilVV2mRXHHGIpcbJBgbi7ZbTMW
 /sUcMXfnPMBOG+KHKiaMCE/HftyyQ7v5jMWdAk+CKxk1YOOw9DjqJhVW8p+UAJyYgELt
 ISDEVqddPrBmlKcRn6dR/9BQsyVDtWHxvr9vkzWn4NcmFn8rU/fBZs4xE3fvQ1oLCOJZ
 D1C5c7e1Ua/y2P8RmpYU9gR2R47RP+AoTaqiDwNntssc+zpXT+r/vZutyj5MO9gFPaJI
 K/qxwouMCB1uvsKV7n7oiYDI3atnh5o35nhK9o/4DZgaFKZzK/BD/2WBDi6AegHN6v9y rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mkfwu81vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Dec 2022 15:44:12 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BKFglRU021062
        for <linux-s390@vger.kernel.org>; Tue, 20 Dec 2022 15:44:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mkfwu81v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 15:44:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKDFe8M024764;
        Tue, 20 Dec 2022 15:44:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mh6yw328b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 15:44:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BKFi6M730867794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:44:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED50120049;
        Tue, 20 Dec 2022 15:44:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 921E720040;
        Tue, 20 Dec 2022 15:44:05 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.72.32])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Dec 2022 15:44:05 +0000 (GMT)
Date:   Tue, 20 Dec 2022 16:44:04 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: remove the last remnants of cputime_t
Message-ID: <Y6HYRNyeZbzC9AGN@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221006105635.115775-1-npiggin@gmail.com>
 <yt9dpmf5ywl6.fsf@linux.ibm.com>
 <CP6FLJIUUT95.3NPVEMSCSRA28@bobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CP6FLJIUUT95.3NPVEMSCSRA28@bobo>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SOhFV0tN3F2qJumMB-_IKkr9Wo5SnkYP
X-Proofpoint-ORIG-GUID: gRW0E8WdOrGWNvzIyZ5iQLraHHJTDm_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_06,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=651 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200124
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Dec 20, 2022 at 04:29:31PM +1000, Nicholas Piggin wrote:
> > > Sorry this isn't build or compile tested, I'm doing the same for powerpc
> > > then we can remove the cputime_to_nsecs fallback from core code too.
> >
> > I just tested this, looks good. Thanks!
> >
> > Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
> 
> Thanks Sven. I think the core code fallback can be removed independently
> of this s390 change, so it can go via s390 tree in your own good time.

Applied, thanks!

> Thanks,
> Nick
