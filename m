Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7CDEB64DD
	for <linux-s390@archiver.kernel.org>; Fri, 23 Jun 2023 09:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFWJ33 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Jun 2023 05:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFWJ31 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Jun 2023 05:29:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECC9D
        for <linux-s390@vger.kernel.org>; Fri, 23 Jun 2023 02:29:26 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N9Miv5018460;
        Fri, 23 Jun 2023 09:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eThdk8+cIGId+7d79qcXDw79+qJRLMGm4WNTmD9YHX0=;
 b=EXZLu3DkkRP/CdsrisrHRI4vKi27GmMsZYotYWrBWrhBYMXZAtYS9bGZlAmwQSs/6wfS
 S4TSfOBzLknJvNeZLcY8SkPsx4JB7vW5X+3WiEzS5byJduVHcG4afvEkjBM6Ke3jCxJJ
 Py3BAU/C5bcwoOVVpbd+Ty2Q23mMpfiLfkqQoPgUSiPTKb+vUWwbN4TpehV5le3NzOH2
 Z765kCOHDO3B/c01DPzzWiTC/gcYlXndyo8fIpiLsR7IE9mJh4STatQjWclzVFmVi124
 k3PPKyXmirjycMCAUERWTvc5KpkefhiGVng4585nR6h/aSPg9yPq4VjVufZRcja0ODIB 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd869gu6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:29:26 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35N9PxFN029286;
        Fri, 23 Jun 2023 09:29:25 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd869gu5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:29:25 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N4RDVP001200;
        Fri, 23 Jun 2023 09:29:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f5b25t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 09:29:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35N9TJo455509446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 09:29:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EF922004B;
        Fri, 23 Jun 2023 09:29:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFE1F20043;
        Fri, 23 Jun 2023 09:29:18 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.5.134])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 23 Jun 2023 09:29:18 +0000 (GMT)
Date:   Fri, 23 Jun 2023 11:29:17 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: prospective 13/12 s390 pgtable_list patch
Message-ID: <ZJVl7ZJiborhmtYh@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fA411EuEnBFhxaNHSDYi6qlvoiJRCMpY
X-Proofpoint-ORIG-GUID: 43ZjWl3Bzm5_hsi9WO2uTRt-8iYQ_CAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 22, 2023 at 10:49:43PM -0700, Hugh Dickins wrote:
> Hi Gerald,
> 
> It's that moment you've been dreading: I'm hoping that you can, please,
> take a look at the patch below, and try building and running with it,
> on top of the v2 series of 12 I sent out on Tuesday.
> 
> If this seems okay to you, I'll send it properly as 13/12 of that series,
> to the full Cc list; but of course you may find I've missed typos and worse
> - please don't waste your time on it if it's rubbish, but so far as I can
> tell, it is complete and ready now.
> 
> Thanks!
> Hugh

Hi Hugh,

Gerald is off until Monday and I think is not able to answer right now.

We had discussions with regard to how to better approach your series and
did not come to a conclusion unfortunatelly.

Gerald had several concerns - one of them is global mm_pgtable_list_lock,
wich is luckily avoided with this follow-up patch. But there were others,
which I am not able to articulate in detail.

While you are doing an outstanding job in trying to adjust our fragmented
page tables reuse scheme, one of the ideas emerged was to actually give it
up: partially or may be even fully. That is - not to reuse page tables
returned via pte_free_defer() or not to reuse them at all. To assess this
possible new approaches some statistics is needed and am working on a
prototype that would allow collecting it.

Note, our existing code is extremly complicated already and we had hard
time fixing (at least one) ugly race related to that. With the changes
you suggest that complexity (to me personally) multiplies. But that well
could be the other way around and I am just not smart enough to grasp it.
At least the claim that page_table_free() no longer needs the two-step
release indicates that.

I am sorry that it is probably not the status you would like to hear,
but I still wonder what is your opinion on that do-not-reuse-fragments
approach? Would it simplify pte_free_defer() or had no effect?

Anyway, that is just another option and I will try your patch.

Thanks!
