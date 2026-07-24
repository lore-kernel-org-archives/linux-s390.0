Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684C41684A;
	Fri, 24 Jul 2026 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888361; cv=none; b=K2M/nQ68HWQQXFMSG7fWXXbkv+C3f0xzIvzI2vEnQSHvIM20UNNc8JrzMU0qaasANOGWGsEFMYWIcpoDMU/kqCJ/yEySs71OU60+ZO+uJ8hifLxxjrKFfuau51XBjXPLMwmZJi8sVCN+/eGKJ0Fhe8r4q/pqiXDoW6ndUnO9FJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888361; c=relaxed/simple;
	bh=izq1Rc/NLDv5bpLr2ryyv9MCwixOY9fmtQpFEl3/LRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPSuAeUCfLio040rmJUlXAUYSyn6hSv/nqzYKo1LCt2IqSwpf6BeWUZZOtPilN6wvNuxeXJf5dqU2Y0ABMlPJtR4wyZ9y1LTNwd7IJu0b5xm5vfR5O1D2+7JzHjeYK/jHOBdAGJjOsQWpM4q2JqQw0YXTIoxU75EEtV/8Co4WOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WWYVLCY0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WWYVLCY0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADOWY1550358;
	Fri, 24 Jul 2026 10:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Azfl91
	jJyYQ69J3jMyxEHSvCpMiTIQ+q2C5X0SSR0Dc=; b=WWYVLCY0cUDD3aQN3nWJmw
	ZlWC8bJfgGGDBDFIvVMqo8oez2Gd7u0LT4JyBCIVLxwoqDRmqDdGy1Kq2WlsAG1K
	vAiKYMQKgczXTKao0PIsH2cY1+BsycZz0s2TQJMunctlP8VM5TSwVTm+AIkJfX9p
	pz39W3ycjHXUI9DssgKrmhx5+nRuvn/I3LGSs8gbMWEsSXfjNPhUbnUBnVhqYtyH
	4lXKsMdusxfJRMjGt74VJKoEpsm1r5oBN6/7amQ8CWWBkZBYysvAc3EZRKf7iM5f
	OmXnG59S6bUGNlCqeAeO82dK/yTViMkC9nYhkT9PtFE9YJDRxW9Kp/UqwK5s0pOw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791c681-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:19:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OA4kA3019884;
	Fri, 24 Jul 2026 10:19:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyr5wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:19:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OAJ6FC38535666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:19:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FA0F2004E;
	Fri, 24 Jul 2026 10:19:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1172020040;
	Fri, 24 Jul 2026 10:19:06 +0000 (GMT)
Received: from [9.111.144.97] (unknown [9.111.144.97])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 10:19:05 +0000 (GMT)
Message-ID: <7a35b2b9-b87c-4e70-85bf-6ef0320ed49a@linux.ibm.com>
Date: Fri, 24 Jul 2026 12:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: fix use-after-free of a severed iucv_path
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>,
        Hidayath Khan <hidayath@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me>
 <178461900540.131537.16161978052316384549.git-patchwork-notify@kernel.org>
 <3da353b3-a159-46ea-83fb-807a2a242e49@linux.ibm.com>
 <20260724093301.9627-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260724093301.9627-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6T9X4Rj-r7NTfcXMgLykuFg6-uWxK61O
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a633c1f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=3CnklmOuJHeadbBvUj0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX8ml3x3UjBg05
 P955pnWxw0dly87UrXFwTE1mbCJ9BPba7S82gu197UFGadgvt4tojnjf6Ue+RMjKaAvuhxIQvUi
 TvkiAEufAu1tvG2wSnjl67s9XWkBX9s=
X-Proofpoint-GUID: ZrVDAOBWlH5XBK1tA2uD6sUZ0Vp7P9eE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX5O+Cu40+azZR
 fRRtVmtR9lo2EC/jxUAdJ+xq5N1TGav7w1UDZ/NksQOO2V8nwx8gqY/v63cxQ1zwA4CwjZka6cC
 thY6VuXjSumyfLqry2+fUPSi0sH7JjlvEZq4jHzXO6CE5ClfZKZA19vGWP0o+JCRE8yqRbIW56Z
 2hyD+V+0BoxtARxu+7zMUV3UGQK2k/LXuTa1MXaRpKEM+PlQMMJD1UHRwz+nKpiPnmdhZxEYVsG
 qJK6H75ruNvQ8sRjrbPv5osXm0/AcRNv1nSVKXXalqfLSABOUO8kdEAU4L8jPEdW+nXh96WDyJ2
 jq5ebuykrRvAtU5YBvngccPlNJC1IKCSTFk5n0UaQ/zkgU9RYjKKD+8Hv+64xk2cTCkUworYNUp
 ThzusWXXl+PySeVxe3K3jvVYuCXg8Y38iyIduArJBu6UfKL2oHkQi7dqD5Jy9JUX080LFckHih+
 JVJaUeDJSnZ6y67yLHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240093



On 24.07.26 11:33, Bryam Vargas wrote:
> Alexandra,
> 
>> After iucv_sever_path it should not be possible to call
>> iucv_process_message_q() anymore.
> For the close path, yes -- iucv_sock_close() ends at IUCV_CLOSED/SOCK_ZAPPED
> and recvmsg() is out, so message_q just leaks. The peer-sever path is
> different: iucv_callback_connrej() severs and then sets IUCV_DISCONN, leaving
> the socket open. recvmsg()'s early return needs message_q.list empty; with a
> saved entry it falls through, and if a datagram is still on sk_receive_queue it
> reaches iucv_process_message_q() and hands the freed path to message_receive()
> -- pathid is the read.
> 

Thank you very much for the explanation. I overlooked that one. I think this
was a design bug in f0703c80e515 ("[AF_IUCV]: postpone receival of iucv-packets").
It doesn't make sense to check the message_q if IUCV_DISCONN.
I'm taking notes for future cleanups.

[...]
> 
> I'll fold the reachability point into the receive-path locking rework and send
> that RFC to netdev and linux-s390, as you asked.
> 

Looking forward to that, thank you.

> Thanks,
> Bryam

