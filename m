Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019E346A04;
	Tue,  9 Jun 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994773; cv=none; b=M9GlW5rhzjrSj4lR+QKLI7zgp0NqRX20yOLNU/8l1Sf97fDPl73CButqPG3HLYzhVvKLH/yWBZR2jud1Ji0i757rJTzVEYmKhc//UB/nYQW8NsozSgZaU+62lTQdq4H3VyYmEVg96q/IqVycc6uZbxAcMcUawq+ycfG4sG++xNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994773; c=relaxed/simple;
	bh=+Jzq/mH1ievdC51DSnjI1a2Udvl1Nvf4SXT6cAzEs14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx1JD3OgZwuxAOUI2vHf4cm+81hYVwlLrImLXWWAZ1t1YSmAvr2Bjspi9uO/5qPY37xZsjDUWEIIi4NBas1wA61Cvaww1BZnrZCyGQ0w1PMx16RjLCyeKyP7poQ0tx/at1kJKQW2TYxXfToXGl8b3OV9EMVx4SFs0a+cH+bFgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VZZodoQ+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VZZodoQ+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658NaYNO4021298;
	Tue, 9 Jun 2026 08:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Jzq/m
	H1ievdC51DSnjI1a2Udvl1Nvf4SXT6cAzEs14=; b=VZZodoQ+oyE8bUTZ9Rfw1V
	ndR25yymvtBpNpGZ4zfe8DBdApvTsi4Kw8NOM62vSJDewzOPvXBiT2VX3oePhgPr
	zYFVd4OYXbqjlXEuPUWkFf+rsXjZ9Qoe7wI5OoqlqX+dDeM/2zhyd1VAZSGowrBl
	V13leufav5qWoFfOvuEQuXtOlQO4EeHhAv/+KHHIiJf9ho0yFYdcSa0Kk6DjBTip
	PJsNaXf4JJXPXbCD/Yo1IXIu2zr+AJ8xrLL39xzQGasnaqWfTByvUF+204BASKbN
	LN8QpAg65RYXqpO8aO1wcttbJV5pLZsDEaY197BK0Nd5OOmc/Ju1LjZOilfI5r+A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye355r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:46:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6598YcMQ022361;
	Tue, 9 Jun 2026 08:46:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g10b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:46:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6598k0JG18284916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 08:46:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3650C20043;
	Tue,  9 Jun 2026 08:46:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F418420040;
	Tue,  9 Jun 2026 08:45:59 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 08:45:59 +0000 (GMT)
Message-ID: <0854d064-f546-436d-9049-230abe6b3526@linux.ibm.com>
Date: Tue, 9 Jun 2026 10:45:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] s390/idle: CPU idle driver
To: Christian Loehle <christian.loehle@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <2e07e79f-dee9-4ae7-a51d-eb132cc4abfa@arm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <2e07e79f-dee9-4ae7-a51d-eb132cc4abfa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OSBTYWx0ZWRfX9DL+Qnlg0TzA
 94Z3WOb4+rKAFbcIsvTgBgUeV2O8Ho16gQiMaKPM5KqkJgDYClpyEvwQHktEtbW6tQpG8qZw082
 ZbL/cKCvVv9seJgur27Y7O9lH3iOUZIPTWLO8O63n/bwU2+nFvI71OfsBHGQiC+N/FbTQSo4LCl
 a+XP4nplcLfNITG/L3RMmnz7RPvAhH1wptvyp9u7kZv9n4W1bC0DsNfVC/94fqnAMzMA7DrFy5/
 TApQguuw6PDidCZuQ+cYqmUKJxLCy0zSZRaLx+nRHG7EX/UHIyzXot7IawSmYcoj+1Th9gaEafz
 n6t2gBjEfR8avHw1i3PIaXBQnQPRworIoHXqWNBJrWn8PbRrhNFf+MZzbHAidDuA5zEwJ0hxVF+
 0Ic/YkA8C2xVmX3g18Tvo4KzmyUFJ427xxCWe/l6mhPKlAmnAfWBk5KqRb/McbCN2/ETwCKldeB
 EvmBQQcD1UxcTAqItKg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27d2cc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ERXlJRJa7KRB2BRJI4wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7uVNSU_U3VqBuHTsFUHuR_wd56JnVnHB
X-Proofpoint-ORIG-GUID: 7uVNSU_U3VqBuHTsFUHuR_wd56JnVnHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090079

On 6/9/26 10:06, Christian Loehle wrote:
> On 6/9/26 08:52, Mete Durlu wrote:
>> This patch series introduces a CPU idle driver for s390
>> architecture that leverages the existing cpu idle infrastructure and
>> TEO (Timer Events Oriented) governor to optimize idle state selection
>> based on timer events and interrupt patterns.
>>
>> # Implementation Overview
>> -----------------------------------------------------------------------
>>
>> The driver implements two idle states;
>>
>> **Polling Idle (shallow state)**
>> - Busy-loop implementation that prevents SIE-exit during short idle periods
>> - Zero exit latency, optimized for latency-sensitive workloads
>> - Maintains CPU with the guest, improving response times
>>
>> **Enabled Wait (deep state)**
>> - Traditional EW state that signals hypervisor availability
>> - Higher exit latency but more efficient for longer idle periods
>>
>> The TEO governor dynamically selects between these states by monitoring
>> next timer interrupts and system interrupt frequency, choosing the most
>> appropriate idle state for each situation.
>>
> I don't quite get the TEO focus of this series, on principle menu works
> similarly, did TEO just work much better for you?
> If so do you know why?

Hi,

there isn't a particular focus on any governor, just reading the
descriptions and trying to keep the solution initially simple lead
to using TEO. Users are free to select any other governor.

There was not a comparison run during benchmarks between TEO and
MENU, just an initial sniff test using a micro benchmark.
