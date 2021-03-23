Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B53C433DB
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 07:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DAB61994
	for <linux-s390@archiver.kernel.org>; Tue, 23 Mar 2021 07:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCWHTY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:19:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229972AbhCWHTL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Mar 2021 03:19:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12N746L1081321;
        Tue, 23 Mar 2021 03:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KSYnCQdS6q7O7N4/z4Kwi4bzj+K3/4Rl2riPX4w+PSQ=;
 b=SsHkqlTHqHg7Xr4TNDwE7TWCzmR78bRXUwr0+TsqIOzY5PfJYuyfmUHlJnFhBo2YqNJL
 rCz0X7rkDspLbW2afi5RSKyIwfuLN0OaqwspghOlkW3gHSzTAo9lTO0sHA72R2aMwbi0
 xLIBv/n78BS2L4OgW/zuVGqnVafW5ml5PqA2Wk3JKLnvv0YlOhgT5sBvBV+zH4710rrl
 P9QurG8FgyeFJHDoMJpp70lP8UAb4Jbncw/nYSFEfQr01vXUHKKFCfbDQaVEnm29NGAY
 vv6QyvfgjeppdBmS1HJq0e9tSsiP564lCmgau4+yy0d4VonnwMBKnt32dkMtoUr5C1tc Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37e03fqck5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 03:19:06 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12N73ngJ079663;
        Tue, 23 Mar 2021 03:19:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37e03fqcj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 03:19:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12N72uPl032311;
        Tue, 23 Mar 2021 07:11:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37d99rb2tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 07:11:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12N7BOtv35258708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 07:11:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9325B42045;
        Tue, 23 Mar 2021 07:11:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D0714203F;
        Tue, 23 Mar 2021 07:11:42 +0000 (GMT)
Received: from osiris (unknown [9.171.52.23])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 23 Mar 2021 07:11:42 +0000 (GMT)
Date:   Tue, 23 Mar 2021 08:11:41 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Li Wang <liwang@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        LTP List <ltp@lists.linux.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [s390x vDSO Bug?] clock_gettime(CLOCK_MONOTONIC_RAW, ...) gets
 abnormal ts value
Message-ID: <YFmUrVOyX4q+8Dy9@osiris>
References: <CAEemH2cELFSMzEYM-Gd1LxNuFzVE2PcG1chzyaVhW2YCJjjzdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2cELFSMzEYM-Gd1LxNuFzVE2PcG1chzyaVhW2YCJjjzdw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_02:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=818 malwarescore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230044
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 23, 2021 at 02:21:52PM +0800, Li Wang wrote:
> Hi linux-s390 experts,
> 
> We observed that LTP/clock_gettime04 always FAIL on s390x with
> kernel-v5.12-rc3.
> To simply show the problem, I rewrite the LTP reproducer as a simple C
> below.
> Maybe it's a new bug introduced from the kernel-5.12 series branch?
> 
> PASS:
> ------------
> # uname -r
> 5.11.0-*.s390x
> 
> # grep TIME_NS /boot/config-5.11.0-*.s390x
> no TIME_NS enabled
> 
> ## ./test-timer
> vdso_ts_nsec = 898169901815, vdso_ts.tv_sec = 898, vdso_ts.tv_nsec =
> 169901815
> sys_ts_nsec  = 898169904269, sys_ts.tv_sec  = 898, sys_ts.tv_nsec  =
> 169904269
> ===> PASS
> 
> FAIL:
> ----------
> # uname -r
> 5.12.0-0.rc3.*.s390x
> 
> # grep TIME_NS /boot/config-5.12.0-0.rc3.s390x
> CONFIG_TIME_NS=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> 
> # ./test-timer
> vdso_ts_nsec = 4484351380985507, vdso_ts.tv_sec = 4484351, vdso_ts.tv_nsec
> = 380985507
> sys_ts_nsec  = 1446923235377, sys_ts.tv_sec  = 1446, sys_ts.tv_nsec  =
> 923235377
> ===> FAIL

Thanks for reporting!

I'll look later today into this. I would nearly bet that I broke it
with commit f8d8977a3d97 ("s390/time: convert tod_clock_base to
union")
