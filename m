Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296A2D594F;
	Thu, 18 Jun 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794052; cv=none; b=dU3FNQemSj38DjSRcdb8PsaKx2akbPbgoWC+jtuJzKX3zWBX+pVXgu8LEKrVFsDkDrlqhEn6HUHC46J8l/lfMHGyaoWuLbewYl30qPuDp3sQe7gB6/Pk882O14U0t1W0bMil0Ov2HhL2MwcGz4kY8QLUbllNVptW7ULFFGz9V04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794052; c=relaxed/simple;
	bh=FjF3eDN3Q4TxvkFHcrhWT74agQHDE0nyUsHV8aQs0xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMu5+5JVXAczvI9LbGi9JXNuvNVvNwBtWiuMzZTnZ816VhoMa45Cg5M0lo8LAYVnJu7t92cZLjlnmwATTEKSAGGTBQ7XfKj3CwqX+Z4uxPVL2FKoAyESyQfcZtG1p9WRenamN5lxs9dcf9MRY5S9p2YNmV0Rw26vcKgsa8VY2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGLcIeJG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGLcIeJG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IEIZTB3598659;
	Thu, 18 Jun 2026 14:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1fnpsC
	cJ1J9do3MGVpA+DcZ+tOjX+ZTvcrj6SyVpgqU=; b=gGLcIeJG4v+k4r1NZkVnkX
	ip9lICisHBpV1nVnUMtZ7AgPmgj4X0j4z1KQHb1r7+uhz8qweLbmErE/tVsXaGxw
	n20vkOlcx6JrKCJV54Kp8frjTN8QQBMt02lFPfIu3RWBIxW7GT5PNUzIGPTW9YKy
	HmuVLX/kT/2L4uVorfCVmbPW3teVE7E8n0UjruPe+BGUwVt2Tfve50qBqNBikM50
	q/jyEIyky3uCm5PaWNVUziTYP+H0IOfF91wwSbo6oqRE9U8cu1IXC5yl5VimrSaG
	GEe/sXCEjkbpH9vWfSBCu7KiAmqdjjZ6T1b0KEVifly0NU5pGVL3Z1I/tjsho/2Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxgjd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:47:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IEYfnT018993;
	Thu, 18 Jun 2026 14:47:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17247f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:47:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IElDCr16187800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 14:47:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFB4420043;
	Thu, 18 Jun 2026 14:47:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1059B20040;
	Thu, 18 Jun 2026 14:47:12 +0000 (GMT)
Received: from [9.111.73.152] (unknown [9.111.73.152])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 14:47:11 +0000 (GMT)
Message-ID: <f280ac2a-7690-42eb-aca2-3cef711d71c9@linux.ibm.com>
Date: Thu, 18 Jun 2026 16:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/idle: Introduce cpuidle for s390
To: Christian Loehle <christian.loehle@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
 <464e277c-40f8-4812-85f6-67b470436692@arm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <464e277c-40f8-4812-85f6-67b470436692@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a3404f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=o96MEzCDL_0u24zMvMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzMyBTYWx0ZWRfXxjnJALE10Qz5
 Zdf+emhXkw3lUZrMCXH2Xaw4OX2hm789Ny/NhPndXwgSCehlY+ixC/Sew+RgNPaOTqV/WAnf7RJ
 2lAY2yXQR9LObv97ZkiJWjwy8UsGzDwW6xIIs0+s0eF6TU5V9ySJz3spqSXqSh1yFm+jEHPPpon
 2Giy2tG1bgY+kOOLky5GVWSQF5SJNz8SbWSJ32znsYUYQAu0U+sB0yzggG8caLbk1ZFnLVAvJLg
 6acoRzTZml55EBbCY+d+D3qBWYmMwyKl12SQQBXehfywNcPfDlBmgCianvVc58C/Ed4EtXFQAr+
 y7r2PxTFHpdt8ZHqZZqPnLRxdmAusXkzWG/iUnIyvh/TJFPMola0EV/QbOCl0owIs7xCKkp4Qvj
 iEJMMQprhzgCp+y7PSf/0IIPgWCkOZJ761cbslu5lBDSnuOfgmxlbtoyo9YH8b6h51CSd9KbtRC
 UK27EgIQfDzuq9hhIQw==
X-Proofpoint-GUID: xoAScTHUfvMx2wf2lGkJvnm9FvS9Jjz6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzMyBTYWx0ZWRfX1nNIhuJyVkzW
 HAnP4dLGJ0hFxUCtGm3UXy0OQ9yN2nubqk30FLWV8PGdrJm464d+1Vs9w+mGiU+bOzJoMlzuowx
 f4buFtZpoFxVrljwB2+d/Lr0m05Adhw=
X-Proofpoint-ORIG-GUID: xoAScTHUfvMx2wf2lGkJvnm9FvS9Jjz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180133

On 6/18/26 4:41 PM, Christian Loehle wrote:
> On 6/18/26 13:00, Mete Durlu wrote:
>> Introduce generic cpuidle driver on s390. Use a two stage approach to
>> handle idle scenarios and use idle governor for idle stage selection.
>> Two stages are, from shallow to deep, idle polling and enabled wait.
>>
>> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>> ---

[..snip..]


>> +static int s390_cpuidle_cpu_online(unsigned int cpu)
>> +{
>> +	struct cpuidle_device *dev = &per_cpu(cpuidle_dev, cpu);
>> +	int rc;
>> +
>> +	if (dev->registered) {
>> +		cpuidle_pause_and_lock();
>> +		rc = cpuidle_enable_device(dev);
>> +		cpuidle_resume_and_unlock();
>> +		if (rc)
>> +			pr_err("Failed to enable cpuidle device on cpu %u\n", cpu);
>> +	} else {
>> +		dev->cpu = cpu;
>> +		rc = cpuidle_register_device(dev);
>> +		if (rc)
>> +			pr_err("Failed to register cpuidle driver on cpu %u\n", cpu);
>> +	}
>> +	return rc;
> 
> Most other drivers allow for hotplug cpu_online to succeed even if cpuidle doesn't, is
> this intentionally done otherwise here?

Yes it is by design. Users would not be aware that something went wrong
if we don't fail here (unless they check dmesg regularly which we don't
expect). By failing here driver communicates that there is a problem
and allows users to resolve that instead of letting a cpu run with
degraded performance.

