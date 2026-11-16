Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842916;
	b=ZG/wlXr6/DfAQjXxx+xpgxJXcN1jzzjPsuJUiz58eGjzNKHlyutbJEcPmFZXM6jv5nHV
	 72pQhrXDMhzzt549YVhFnjOYOaNFuWQy3bt3ZPas34av52TnPFzalh4sbkhBHtFdtn57o
	 laU7NXAHRe0Yhv5fmzm7PwUNJL/DNoMUrvF3V7VooxG/H7PKFQxNwD3BzNAtHDCfKa2iZ
	 OtWJxrZN1Kiy+79TX+JXhAWpLcEs8dUI1zl9wb4Xfiu4ewyMQ4yFV8ac4kGrJ2k584aJG
	 769yXV+owPb7DSk8mvRSAVSpafPhRPEoNpStu0zKfqAzSBA2R2fAuu6pWOpZVQi0Xtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xptZYPDAQTj3l9jWzdgLCCl+UiBE0vVZqBjyqpYLXog=;
	b=X5xBpPdbvlFATF47bNZwU6WIqLSJrfHef+8o0yEgg1z7xc7aDzhIvucp5LAyKLByx845
	 7wrZ1Ju/bVsNC90LNw7P1YSDgUwAPuWtjE2QI/GUXKsqhWhEvMqVRjF5kz9lzJbyFRgZ/
	 kbAFeCAzq1kX1TnrZOaScS6Rw8uWRn349t1hWXaA9S+kB+alIk28/jU64ua++iPO/TsW4
	 rQS4DwfkU4Cl6l2JApgCANmz2ix2qGbECBOXgMh0MxUGQ/XhCa/Q5bcq28Ksi5+zjE/qy
	 Co3mRaLYlAms2Qt4UKTztivgYlx5Cl3cx/uA/7fRK+uPyh4Zx1+YoBwq63AUVqFpqaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dHwYQhfm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813FE606A323;
	Mon, 16 Nov 2026 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 813FE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dHwYQhfm
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDu11r3407802;
	Mon, 16 Nov 2026 15:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xptZYPDAQTj3l9jWzdgLCCl+UiBE0v
	VZqBjyqpYLXog=; b=dHwYQhfmVTFZiPnd5U6ir8G8LdliLacIJ59Py+is/DiwTp
	40VOAS63MpSKWrqctTH/+pvid1a9+E7mGtn7LPND8m5H4QClqsZXJiDp/tJ6W0Wf
	egzdDkNYBVUJ6bOqD5fqG0Y2Fd+k4PLySueg31kMghhO9cXJWX2Ds4j2NTaHJk5+
	fksEx20urRC/OomV8ncwtROERrdfxAKyd2EYBpyxrBNahOAnESFgFv8uMYKcJxTa
	TcjZCOR5B/aATS3islMuHB/TIcA3ublN65nFuGSR0Ka4wwmipLMdnkh8jhVUKeJ3
	kvOKak6Bj+c4K9GV/ERxfqdK7w3Ivfj075raEIcg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2kx02v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:28:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGFC49F2972402;
	Mon, 16 Nov 2026 15:28:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00ns9a30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:28:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGFSDWr30933298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 15:28:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA6F20049;
	Mon, 16 Nov 2026 15:28:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 605E820040;
	Mon, 16 Nov 2026 15:28:13 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 15:28:13 +0000 (GMT)
Date: Mon, 16 Nov 2026 16:28:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/14] s390/sclp: replace page allocator calls with
 k[mz]alloc()
Message-ID: <20261116152811.165348C35-hca@linux.ibm.com>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afb211d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=RFWjAfAvn5XsmgsbDIkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: j8eG1yej94bfWv88N2-2XTDuffFF76CY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MSBTYWx0ZWRfX+x6vtnQgWfwA
 jwKnlBTp9JiMPvZnGVchhpLgnBHf0JgsnQFzoYRr8P35rCshGAOeJfm7gLde5GMxyEt/l8eh2U5
 V0cxdApBLJIHZK0csJF1Nf99HwqBPWk=
X-Proofpoint-ORIG-GUID: j8eG1yej94bfWv88N2-2XTDuffFF76CY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MSBTYWx0ZWRfX026B3Y2k4d3D
 a7KazmPylNWpybs2zmfMsiRjsNQGbGlD3AaiB6SBqYKQvh7hY/wgFDjbmZM6xCdUlqECZi8EqwL
 BoMm69EuI8fwmZwYr1tDewxxl59VOBg/3btkwhB3nPCJlC8vOZXDkcRJHrutdp4YG+XIi181G6J
 AhfEKsTG8Z0S2Ddjzumy/Y6fmF6Wfna4K0nIGXN1bxltOprLrqc7LaMZS6RkBuBIQW05pagaL/H
 XwiLQ0UFWf1fjljurWteADLysrYpavK7Q55luBHGzGIDKBoBmjyOxKN+5HtqlQOrGD7RZJr2ToZ
 UV8sekVudsKIrDM1ydZVgO3zulmRC6UHHG+rqZpBvc5Dayn913baZgTFMKZd8MN6uVyMY0icjs+
 90e/j2mSNKIWVQJXZyXzbFCTJ/LnfnveBTaBPkm/fxzuqEGCP02kEpYDK2xijarc+H98DsgucRr
 a/ky1Rfxxd3NlxZuwJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160061

On Sun, Nov 08, 2026 at 10:58:31AM +0200, Mike Rapoport (Microsoft) wrote:
> This the next episode of conversion of page allocator calls to kmalloc
> family :)
> 
> This series covers SCLP buffer allocations.
> 
> = tl;dr cover letter copied from the previous posts:
> 
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.

Series looks good to me, except for the two small nits.
Feel free to add

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

to all patches, except the two where I left comments.
