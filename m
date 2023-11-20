Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CDFC54E76
	for <linux-s390@archiver.kernel.org>; Mon, 20 Nov 2023 09:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjKTJLm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Nov 2023 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjKTJLj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Nov 2023 04:11:39 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD996B8;
        Mon, 20 Nov 2023 01:11:35 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK8cIEE023567;
        Mon, 20 Nov 2023 09:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2jdHnpx6mgSC4QZnlzzc1n6bb3Xg9JCcs3d0KBlV+Lg=;
 b=ndxwOge7rEeBiR8U73VZEFeQSHJf5ijiC6XXwzyyF+nENrwtVk6ONSVTwpm3nlwVS0I9
 NPFeY0L4d20CQOShkFsrF/gogL/0IQshh78P3Vfnn4yZscGNl9OeEQOgtE73IUnovivX
 IeddW4lH0uQ0KL42c++bpv8FD3hyUnPWe9/3z7DPYkoUz+JRscqET/x4ehpaOxtzekso
 55IK5+36sNu4k6Migjxpk1ttou/NQZen/HJNnm+WtiPq7rEyLVggYnoxvGSPAtfr3dk9
 KH2vrRCpMP+JysP6JpHlpoHub9Z90JFwfA3bUjn2YEHGN7QTzOBCKtB0TJo0ZN7EEdih iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug3u19dee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:11:23 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AK8JoiZ020066;
        Mon, 20 Nov 2023 09:11:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug3u19de1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:11:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7KMUK008904;
        Mon, 20 Nov 2023 09:11:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy89um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 09:11:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK9BJws17433176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 09:11:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AE2E20043;
        Mon, 20 Nov 2023 09:11:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42C8020040;
        Mon, 20 Nov 2023 09:11:18 +0000 (GMT)
Received: from [9.171.73.39] (unknown [9.171.73.39])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 09:11:18 +0000 (GMT)
Message-ID: <22394c7b-0470-472d-9474-4de5fc86c5ea@linux.ibm.com>
Date:   Mon, 20 Nov 2023 10:11:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Content-Language: en-US
To:     dust.li@linux.alibaba.com, Li RongQing <lirongqing@baidu.com>,
        kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.co,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <20231117111657.16266-1-lirongqing@baidu.com>
 <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
 <20231120032029.GA3323@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231120032029.GA3323@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jN5Amf-NvPCU-WS66WFFzeXaSk9g3GrM
X-Proofpoint-GUID: JMfWIMqilLN5oGGFL3DeUEgQLcBL9Gbk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_06,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=834 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 20.11.23 04:20, Dust Li wrote:
>> It seems to me that the purpose of conn->tx_pushing is
>> a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
>> b) Repeat, in case some other thread has added data to sndbuf concurrently.
>>
>> I agree that this patch does not change the behaviour of this function and removes an
>> atomic_set() in the likely path.
>>
>> I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
>> So how can we ever run in a concurrency situation?
>> Is this handling of conn->tx_pushing necessary at all?
> Hi Sandy,
> 
> Overall, I think you are right. But there is something we need to take care.
> 
> Before commit 6b88af839d20 ("net/smc: don't send in the BH context if
> sock_owned_by_user"), we used to call smc_tx_pending() in the soft IRQ,
> without checking sock_owned_by_user(), which would caused a race condition
> because bh_lock_sock() did not honor sock_lock(). To address this issue,
> I have added the tx_pushing mechanism. However, with commit 6b88af839d20,
> we now defer the transmission if sock_lock() is held by the user.
> Therefore, there should no longer be a race condition. Nevertheless, if
> we remove the tx_pending mechanism, we must always remember not to call
> smc_tx_sndbuf_nonempty() in the soft IRQ when the user holds the sock lock.
> 
> Thanks
> Dust


ok, I understand.
So whoever is willing to give it a try and simplify smc_tx_sndbuf_nonempty(),
should remember to document that requirement/precondition.
Maybe in a Function context section of a kernel-doc function decription?
(as described in https://docs.kernel.org/doc-guide/kernel-doc.html)
Although smc_tx_sndbuf_nonempty() is not exported, this format is helpful.
