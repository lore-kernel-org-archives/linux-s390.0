Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC703C43334
	for <linux-s390@archiver.kernel.org>; Tue, 12 Jul 2022 05:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiGLFhL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLFhK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Jul 2022 01:37:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDEA8AB35
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 22:37:05 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C4n7kk015942;
        Tue, 12 Jul 2022 05:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=dz6EpKG1goiQcPZkBfKhO05SGPnJhwjgiINYJMRebBA=;
 b=DAvznQyJx/Gpo/ZGskUXI3G+jMw9m7eKDqURsH287eM3QGQLfRircw8nYZZIv/OBQK3G
 hx9yk+MCILu7/dkcbEiJbVLRbn2bIU7X2qHFuM34yBvckhfVWgTy2zd9FrTkNK9YVqaV
 6blL+KWWuPqIcDatkhpw5f5G+UrkjD7367EJjT1u3VGthhIcQIaX5TfEYBJ2fXoQVARt
 ZKr2GGR+JmlJZXE/vNGOejkWM6rhL99FIu6w2fSnd654/zAUY3b+G78FY+dDPwlkTpAM
 XNoNMzW2q1RDU8wXb8hQm5NPbJZUwc5I35chn1HXsXXjsRhZ5NoxdTpbh86RyAieYfzi 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h928wrw3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 05:37:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26C5ZIfV008557;
        Tue, 12 Jul 2022 05:37:03 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h928wrw2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 05:37:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26C5KIqF025049;
        Tue, 12 Jul 2022 05:32:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhupfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 05:32:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26C5Vwrf20840898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 05:31:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF1674C044;
        Tue, 12 Jul 2022 05:31:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 887104C040;
        Tue, 12 Jul 2022 05:31:58 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jul 2022 05:31:58 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] trace-cmd: fix writing of uncompressed size
References: <20220711094340.2829115-1-svens@linux.ibm.com>
        <20220711135146.35e163b0@gandalf.local.home>
        <20220711141539.59727f34@gandalf.local.home>
Date:   Tue, 12 Jul 2022 07:31:58 +0200
In-Reply-To: <20220711141539.59727f34@gandalf.local.home> (Steven Rostedt's
        message of "Mon, 11 Jul 2022 14:15:39 -0400")
Message-ID: <yt9dtu7m5229.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _A2gLK9E9veW_uVgthKKz3sVFOeSq8EX
X-Proofpoint-ORIG-GUID: eVUW9Vlt5b9LrtGwX8ObDo3gDCLxiNpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_03,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxlogscore=905 impostorscore=0
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207120023
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Steve,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 11 Jul 2022 13:51:46 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> Can you resend and Cc linux-trace-devel@vger.kernel.org so that it gets
>> added to patchwork.
>
> Actually, I'll just send it for you ;-)

Thank you! :-)
