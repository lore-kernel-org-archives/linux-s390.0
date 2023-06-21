Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF5CEB64D7
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jun 2023 13:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjFUNt1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUNt0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Jun 2023 09:49:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F421B19B;
        Wed, 21 Jun 2023 06:49:24 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDRsSM000541;
        Wed, 21 Jun 2023 13:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LvvdhNoYFf9QQ1pM8u6flQ/3zFwCp/F+Ew4BYbRELJs=;
 b=s3XorvZmlHMUkhM24z4moG4R0yNdI9hc1msfqrfXkZERVjUUP7ha8P6ZNZ5B1Eubs/zd
 Y6z3A2wr4VkAXayDb8rGiOhM/RwA4BNg2NqUuE2vbFKUssfyMq5xAnwKqT4gE9EUi38m
 KTq58d/H5z9qs+yGLOoRg9ZgbNTbbhBKXMep8UdQZ4657e1FLhc1qAkzrNvLN4T2HoV+
 zT66TVepIK4nmjeDCP6SuibX8l/K/dFZcJcG02C7Fa2aGth+cVsgs4NLhK3MH55un6Tm
 YIiQMvEUCUtZMwqa5RF4IreEQpDY427wLCL2p8/93T80+1ejBK9Fv7vYBcEqZ+NCXucw ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc1f5sp4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:13 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LDBGSx020578;
        Wed, 21 Jun 2023 13:49:12 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc1f5sp3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:12 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L5tnwa026383;
        Wed, 21 Jun 2023 13:49:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f5a3s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LDn7rM39453262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 13:49:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2540020049;
        Wed, 21 Jun 2023 13:49:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDED320043;
        Wed, 21 Jun 2023 13:49:06 +0000 (GMT)
Received: from [9.152.224.35] (unknown [9.152.224.35])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 13:49:06 +0000 (GMT)
Message-ID: <4ae0428a-feec-e78e-f0f7-c08493959e74@linux.ibm.com>
Date:   Wed, 21 Jun 2023 15:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 2/4] s390/lcs: Convert sprintf to scnprintf
To:     Simon Horman <simon.horman@corigine.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jules Irenge <jbi.octave@gmail.com>
References: <20230620083411.508797-1-wintera@linux.ibm.com>
 <20230620083411.508797-3-wintera@linux.ibm.com>
 <ZJH7E20GZ1YH8HSd@corigine.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ZJH7E20GZ1YH8HSd@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TPGMvJCvUBZhRJrTGu1aZiWrqDnSANnG
X-Proofpoint-ORIG-GUID: yNeXvGM70MwVnyYnct0LZImtTK4YL7LW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 20.06.23 21:16, Simon Horman wrote:
> On Tue, Jun 20, 2023 at 10:34:09AM +0200, Alexandra Winter wrote:
>> From: Thorsten Winkler <twinkler@linux.ibm.com>
>>
>> This LWN article explains the rationale for this change
>> https: //lwn.net/Articles/69419/
>> Ie. snprintf() returns what *would* be the resulting length,
>> while scnprintf() returns the actual length.
> Hi Alexandra,
> 
> Although I agree that it's nice to use scnprintf() the justification given
> seems a bit odd: it talks of the return value but it is ignored both before
> and after this patch.
> 
> Likewise for some of the changes in patch 4/4.


You are correct. The main improvement of these patches is to get rid of sprintf.
And we decided to use scnprintf everywhere. I'll send a v2 with a slightly
updated description.


> 
> Also is it intentional that there is a space in the URL immediately
> after 'http:' ? Maybe mangled by something. Not that it really maters
> AFAIC.


Thanks for spotting this, Simon. Corrected in v2.
