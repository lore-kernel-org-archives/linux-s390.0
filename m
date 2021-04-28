Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B4AC433B4
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9616E6141F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 13:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhD1Nkf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:40:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229891AbhD1Nkf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 09:40:35 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SDXrZB045116;
        Wed, 28 Apr 2021 09:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Yzm4WxpneRJAjka6d6u6hB5NqVPyZheXRjCRS8mJPq8=;
 b=thnUPFnUaWiyUOIAGuygCLOuxYSz16DuyN44IiskwaW8QEVlwVC4eu1+bMfLw2UqaMuF
 Crjn6za41iT8Jw90DkTcMNtJv3TdL+YGV9xzfnAGORs7PXhqA6oMQnr9HdXvclis3no/
 +YlHe+9TAJLSAlM2Mf3zXPOe91l0LcljFoI6wk1gGvl9Fiqh1Lr2ceq94Lq3WA+u4ADB
 exLWns7+IQPaJ2ZpWRajKSI4GsWO9BDKahE/12TpuSjicwoF5vpOZsNDBrzsckzykOj1
 ieQwCGhzBHkqorAP7W91/d/+TiT+ZAe7N5ILHuYsFzLSSn7fdTj+C+qm1h8IV9UVHLU5 7A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3877t5j45v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 09:38:43 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SDcfIB032418;
        Wed, 28 Apr 2021 13:38:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 384ay8h2qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 13:38:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SDcb4g28311988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 13:38:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A96252052;
        Wed, 28 Apr 2021 13:38:37 +0000 (GMT)
Received: from lynx.boeblingen.de.ibm.com (unknown [9.145.41.187])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 75C9E5204F;
        Wed, 28 Apr 2021 13:38:37 +0000 (GMT)
Received: from brueckh by lynx.boeblingen.de.ibm.com with local (Exim 4.90_1)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1lbkOi-0003Xu-Ee; Wed, 28 Apr 2021 15:38:36 +0200
Date:   Wed, 28 Apr 2021 15:38:36 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philipp Kern <pkern@debian.org>,
        Benjamin Zimmermann <dave@oss.volkswagen.com>,
        debian-s390@lists.debian.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v2] s390/sclp_vt220: Fix console name to match device
Message-ID: <20210428133836.GD21939@linux.ibm.com>
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
 <20210427194010.9330-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427194010.9330-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DcekuhYotr_7hh_F4YXh-sdz3NMOpZbU
X-Proofpoint-GUID: DcekuhYotr_7hh_F4YXh-sdz3NMOpZbU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_06:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280091
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Valentin,

I just had the chance to look into this console topic yesterday.

On Tue, Apr 27, 2021 at 09:40:10PM +0200, Valentin Vidic wrote:
> Console name reported in /proc/consoles:
> 
>   ttyS1                -W- (EC p  )    4:65

It is been a while ago when working on consoles. However, consoles are
typically devices without having a device node associated. There is special
handling for /dev/console wrt. to the preferred console in the tty layer.

A console device might be associated with a tty device but this is not a
requirement. For example, consider the net console that streams console
messages thru UDP and is not associated with a tty.

Because console and tty are different devices, names can also be different
which is, unfortunately, the case on s390.

Therefore my suggestion here is not derive the tty device from the name
of the console, but rather looking at the associated tty being reported
as major minor number in /proc/console.

> 
> does not match the char device name:
> 
>   crw--w----    1 root     root        4,  65 May 17 12:18 /dev/ttysclp0

In the example above, 4:65 excactly ends up in /dev/ttysclp0.

I am also in contact with Christian and thanks to him to try this out
internally.  At least, there are options to bring this forward and let's
figure out what the best solution will be.

Thanks and kind regards,
  Hendrik

-- 
Hendrik Brueckner
brueckner@linux.ibm.com           | IBM Deutschland Research & Development GmbH
                                  | Schoenaicher Str. 220, 71032 Boeblingen
