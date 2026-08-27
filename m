Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC459391842;
	Thu, 27 Aug 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829319; cv=none; b=N2nhiJR5SqyQVRK6bGwekBBZYnVLz1RF8gcVCClu26PAshK18gaYcZ5NU8LhSJjscmOdYYcJQ8fEU9Ya33SW63DFS5n9L3phmEOCVZAoGWJEiB0bB9eQKKiGa3v5FmdBFqWE4sdxalFQgAe5AqJPFD1qCUrdgf5kXlMpNsyFoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829319; c=relaxed/simple;
	bh=kMffwQp7QJmgRqeS4+ibpI4m911rke1OCCAhP4E3MkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+hP+4gQXNuZRB5Ll4nsbhfHwM1/Q3tp+IV0mpLLvY6A48J07PrvupyZFvwVsfS7gpbdb8HirR/uYMJo8ZsLYA5h3zb7Ih7RWLO14T/jxIOXh8e0JWVvA5MEYuUuopUSFy1rJiqMMXkzEQnKaQsuZ3OBJrkb9ugi2psqfBSIoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ytm7LBMA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ytm7LBMA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9VfAg731829;
	Thu, 27 Aug 2026 11:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B0FsYX
	UywV5BIPLK1dyqVmLPLQYunEhLYe1qEaTUCCs=; b=Ytm7LBMAaj0ADIY+oIDR+v
	rc7Uc+l6NDGJ5JTuIV8IlKFv8csMST3CtbKszl0tCl/1o2c6jIju8rnsedZUC/0k
	lx9mk137NoP3QHsr8zTZc40tH7c19eCmSY1Eiq07PFjvvOjQKU/wArtty8xe0kOV
	T4h7EH2ls/KeGUBfHVMgIp4sq+DwAme0nojkVyyO4EZOHrYRQ4XtcMi+2ZorDXgv
	iUyNv/wjgSCSGoRqSMfZrs3Tzm82dxt3OlMKg7Ha8o7k8XL+PMP41RNgM8l7zydZ
	N8ehGtWNEaW86vyQq6oLqfZb1RGzhzzwLqnzOkkig9BI32i2SEkFef5flejOHUUw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er4uss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 11:15:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RBBIa0029758;
	Thu, 27 Aug 2026 11:15:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qfwd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 11:15:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RBF9n251511588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 11:15:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D054020040;
	Thu, 27 Aug 2026 11:15:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A82E20043;
	Thu, 27 Aug 2026 11:15:09 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.64.177])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 11:15:09 +0000 (GMT)
Message-ID: <c641bbfe-04cb-4f2c-8533-1955368931a1@linux.ibm.com>
Date: Thu, 27 Aug 2026 13:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Warn if kernel command line contains non-printable
 EBCDIC characters
To: David Laight <david.laight.linux@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260825150840.537653-1-iii@linux.ibm.com>
 <20260826145129.204b6517@pumpkin>
 <4ed90c1e-0edf-4d12-b4d7-d439a8113669@linux.ibm.com>
 <20260827093224.6d4b1971@pumpkin>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260827093224.6d4b1971@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Y7oVLa6tKloRsd5F8x1tJf1zjeDGWHbr
X-Proofpoint-ORIG-GUID: PPkaj8Scknf73jeFwcLxVQncgTlSCvOl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5MSBTYWx0ZWRfX+UavrJkfZSMQ
 0ggO4vUNR0v0soDsnFY9e6pTygfYjkE/JPgisthPGtWj62+MCfDJpSf0sBNmxCtmlDk/R1fRq6X
 EC983zNel/IremOAYnTWGNXCNSuepnKU1cjGwguZ0g5KDPnb9V2ZadgOeJtXkIZ+r6N84MJKLJE
 p6WZDLQmT1Kl1QBGTF4k8b/iRK9P966Si/MXx8d9exfmkGbPOF1wdRzHFNELTjCtR3Dg9Bqwokf
 RjN2ClyMv+KE+gWW7G7FCPNcb2qsDuMI3yKwtZXAzBhb4JMtQ6ra7XDa9ARejL8IlevYduRoElA
 z60u0z2bRV7IZZWXrluxkN9vmaPwz4nBOsGYElnxuuJwM6kvQ4LSkfQDiUXu8d8F07pdA9cTlSs
 MAe4+cHEbzGhn7jEN3ZdqWXCxKTGeh01VEICK/5Fkab3b4Va8XyZRq+PrRG4lg3Br6yGxt0JoZa
 SKtmCHi8FCsBlFehgSw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a901c43 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=SQuqiZtJNYRooU-z6-4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5MSBTYWx0ZWRfXyGXJg6TnkN9f
 +KloDqNqMEqsc27+R0X+UUK9cnM7sdq0raCbp7OXz2oWnZP2y4MFmdU13CxbmIvsn7eewa2Ocn8
 xW491VnKREtT44+bJHIjxZT/8WB3DBk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270091



On 8/27/26 10:32, David Laight wrote:
> On Wed, 26 Aug 2026 16:08:50 +0200
> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> 
>> On 8/26/26 15:51, David Laight wrote:
>>> On Tue, 25 Aug 2026 17:08:08 +0200
>>> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>>>    
>>>> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
>>>> parmline, for example, by copying snippets containing non-breaking
>>>> spaces (\xC2\xA0) from web pages.
>>>>
>>>> The kernel will then interpret the entire command line as EBCDIC,
>>>> making it unusable. Distinguish this situation from the legitimate
>>>> EBCDIC conversion by looking for non-printable characters and issue
>>>> a warning.
>>>
>>> Would it be better to check for the entire line being printable ebcdic?
>>> All of EBCDIC a-zA-Z0-9 have the 0x80 bit set and most of 0x20..0x7f
>>> are invalid or control characters (or punctuation).
>>>
>>> David
>>
>> I actually started with that, but this required introducing a new
>> _ctype-like table (unfortunately it's not as simple as checking a
>> couple ranges), so I decided against that and took a shortcut via
>> ASCII.
> 
> Could you get the conversion function to return an error if it found
> invalid EBCDIC characters?
> If there is a single UTF8 character (eg non-breaking space) you really
> want to treat the line as ASCII.
> Actually you could count the number of characters with the 0x80 bit set.
> If more than 1/2 assume EBCDIC (all of 0-9a-zA-Z have the bit set).

I also considered that, but setting any threshold feels arbitrary and
will probably fail for punctuation-heavy command lines.

I also didn't want to make it a hard fail, because I'm not certain that
I know all uses cases. Perhaps there are people who wants umlauts and
what not? It would be bad to break whatever they are doing.

But at the same time it was very painful to debug the &nbsp; issue, so
I settled for the compromise: add a warning that will be helpful to
99.9% users and will only mildly annoy the 0.1% umlaut users.


I just had an off-list discussion with Heiko and we think about going
with your first proposal for v3: a new _ctype table for EBCDIC for
determining whether characters are printable. The overhead from this is
not bad as I thought it would be.
> (I didn't realise anyone still used EBCDIC.
> I guess the unix implementation(s) use ASCII (otherwise too much code
> is broken) but the old IBM OS uses EBCDIC.
> I worked for ICL for a while, their old 1900 series (from the early
> 1970s) used 6bit characters (4 in a 24bit word) that were ACSII codes
> 32-95. The replacement 2900 series (very late 1970s) used EBCDIC internally
> (I guess because IBM used it...) but all the peripherals were ASCII.)

Linux on s390 still uses it for interfacing with traditional IBM
hypervisors (z/VM and PR/SM), which are very much alive and used today.
> David
> 
>>
>> [...]
> 

