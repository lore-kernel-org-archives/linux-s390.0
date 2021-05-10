Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EBAC433B4
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF9C610FA
	for <linux-s390@archiver.kernel.org>; Mon, 10 May 2021 14:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhEJOIv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 10 May 2021 10:08:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15043 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236156AbhEJOCP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 May 2021 10:02:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ADZw2a030316
        for <linux-s390@vger.kernel.org>; Mon, 10 May 2021 10:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=hEE3p+62qude9FdLfexQW1a/Im/NtJhtX5VsdyO4cG0=;
 b=h55Msg/PMydTeQImD8wqf3qjRFfJeopoAT1/ke/LuzVOM88XbqoJ+VJvUds4qjHBkZV0
 A+3pDeyC/4Z+Lc91Ggl7iRjgwmdf7BM7M1eh2lTe9B+mBTa5U9EpoPB6s00ZyMaoQ9+l
 Sckb6+5Np5I+eFhZJqeCWQ/pj5PcRXaLsl8DgCGebg7YcJTydo/gy2lkRI+Mrnh+hlLl
 NiPN1cq9+KiG6h8IylgP5uHxsF+NMX6i2QUcTfDKor5MzhaRAOS/yQybLWc/IRSoPIGR
 aRjuhSaPXQ9u2xNyPt0STE193E9Xow0yZQSTZsa/eeYLOcK/q9pgdtqXkUUtByWgXL/j 8Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f487uq1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 May 2021 10:01:09 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14ADweKP016845
        for <linux-s390@vger.kernel.org>; Mon, 10 May 2021 14:01:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 38dj9890jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 May 2021 14:01:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14AE11Jq20316574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 14:01:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADFA64C071;
        Mon, 10 May 2021 14:01:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4978E4C05E;
        Mon, 10 May 2021 14:01:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.4])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 May 2021 14:01:00 +0000 (GMT)
Date:   Mon, 10 May 2021 17:00:58 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
Subject: s390 and crashk_res 
Message-ID: <YJk8mrW7DdwwhLuE@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oaNK_MkinFFcD_R3DjkF0-wfUffI3kvj
X-Proofpoint-GUID: oaNK_MkinFFcD_R3DjkF0-wfUffI3kvj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_07:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=439
 lowpriorityscore=0 adultscore=2 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105100089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

I'm trying to consolidate setup of iomem_resource as it is very similar
across several architectures.  

Among the differences I've encountered is that s390 keeps crashk_resource
is not a child of "System RAM" and commit 4e042af463f8 ("s390/kexec: fix
crash on resize of reserved memory") added a comment that explicitly says
that "... crash kernel resource should not be part of the System RAM
resource".

I could not find what is the reason for this neither in the kernel nor in
kexec sources.

Any help will be greatly appreciated!

-- 
Sincerely yours,
Mike.
