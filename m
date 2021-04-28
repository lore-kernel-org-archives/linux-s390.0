Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D3C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 14:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9086142A
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 14:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhD1Opq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:45:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236337AbhD1Opp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 10:45:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SEX3LK086782;
        Wed, 28 Apr 2021 10:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lIC6A5oB6OGQNOiBi0aVyLDo0memk3cfKqRtYQ5ufYk=;
 b=qNHe+j9Gk5hrDVWnWQiJmtpAIWlLkL1SQewoTp5As/kJEGQ9XAuTP/HhrTcAIH1OD9sO
 hKtPFQH7+llooZDQk+Ar6FfpOzg3aHxFtyydnoylToHsyqKDF4A6DdhqOlTgfR4dxXyM
 RmAf32pZFzu561k14YH0k4kgfxdx6NAwHPmmcdgxKXmVoWbrxHJ/tu56vrLAU3n6s3nd
 4IbCn97vXIF2APA/a8FiiLr7KwRknV3/fbOK8jUIVUkly5b2pAnrT8wD2pNWvboHlraS
 vdhDJSWs2ADjIiADt4+G3L3EoSH81lkBWshK80SMi4+EN4hu1Qo0R/XHA/fFlGl0C/iX uw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3877h8w7r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 10:44:45 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SEhm0m015326;
        Wed, 28 Apr 2021 14:44:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 384akh9xs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 14:44:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SEiduf38994264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 14:44:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD464A405F;
        Wed, 28 Apr 2021 14:44:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DB96A405B;
        Wed, 28 Apr 2021 14:44:39 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.77.184])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Apr 2021 14:44:39 +0000 (GMT)
Subject: Re: [PATCH v2] s390/sclp_vt220: Fix console name to match device
To:     Hendrik Brueckner <brueckner@linux.ibm.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philipp Kern <pkern@debian.org>,
        Benjamin Zimmermann <dave@oss.volkswagen.com>,
        debian-s390@lists.debian.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
 <20210427194010.9330-1-vvidic@valentin-vidic.from.hr>
 <20210428133836.GD21939@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <80735c89-a18a-5910-4e0c-f27eaa513578@de.ibm.com>
Date:   Wed, 28 Apr 2021 16:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210428133836.GD21939@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8ht8VbbS-BOi2ypmp0ta7J_S4Y7uS2o_
X-Proofpoint-GUID: 8ht8VbbS-BOi2ypmp0ta7J_S4Y7uS2o_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_09:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 28.04.21 15:38, Hendrik Brueckner wrote:
> Hi Valentin,
> 
> I just had the chance to look into this console topic yesterday.
> 
> On Tue, Apr 27, 2021 at 09:40:10PM +0200, Valentin Vidic wrote:
>> Console name reported in /proc/consoles:
>>
>>    ttyS1                -W- (EC p  )    4:65
> 
> It is been a while ago when working on consoles. However, consoles are
> typically devices without having a device node associated. There is special
> handling for /dev/console wrt. to the preferred console in the tty layer.
> 
> A console device might be associated with a tty device but this is not a
> requirement. For example, consider the net console that streams console
> messages thru UDP and is not associated with a tty.
> 
> Because console and tty are different devices, names can also be different
> which is, unfortunately, the case on s390.

another example is the ttyS0 console which is called sclp_line0 as a tty.
Doesnt the debian installer thus also fails when running in an LPAR?

It might still be a good idea to actually change the console name for the
ascii console as you patch does.

> Therefore my suggestion here is not derive the tty device from the name
> of the console, but rather looking at the associated tty being reported
> as major minor number in /proc/console.

So yes we should definitely try to fix the installer program as well. All other
distros seem to handle this case fine.

> 
>>
>> does not match the char device name:
>>
>>    crw--w----    1 root     root        4,  65 May 17 12:18 /dev/ttysclp0
> 
> In the example above, 4:65 excactly ends up in /dev/ttysclp0.
> 
> I am also in contact with Christian and thanks to him to try this out
> internally.  At least, there are options to bring this forward and let's
> figure out what the best solution will be.
> 
> Thanks and kind regards,
>    Hendrik
> 
h
