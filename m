Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDF2E9EB8;
	Mon, 20 Oct 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951865; cv=none; b=LdoUHIh76HFVV4ROslR7gTgj/xpBjw+/kkt44IdjniOh8v8naFMNGIw0mEF8GnUZVlPtRorVON8QbqF8/iogWtc3xNXyyW7nN0AmIl4LN7y9hKOwsUETcsqr90j+R5omtLM8OrCWXrZe4q805PkuOwJJfJvOXOeRkTXlEV0SBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951865; c=relaxed/simple;
	bh=3l3wdWQKrGObOqU4MwS5hghEQARNxgr0FIg33Av1Tl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWJM8LNUUkg4W2YFc84g20o3VYO9h3ASLC7eaP82IaOBgrWfwjEZqiQGQvrdJWEzLnuuV98im+sZ/dycTIOlFo7QU5apXop2NIrA9FxubAAlIb1FnVmDIBpzXJBLZpRC5js5xql+jsY9uhketeqfrJg+YZEHseLEoG85K/WGVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sMJt27OG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sMJt27OG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K1nWil009802;
	Mon, 20 Oct 2025 09:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=M+py6AMn6297S/l7VDb2nflKXjz0fa
	MooP7b1M94RtE=; b=sMJt27OGuY2hWtLarqchUfmAhq/Jv61yactrinVfn9PEfN
	Za3T8Kt8LoQv6dHah9WxMI4NNGWoqRLvbbsMWjrEJ2SX5gISaiHoGOM6c9LlXXOm
	57mPIcpNWzOpbOOiloDPE8dlHlabWS9KgDEjwpwIjHxScgRgCLl90ajJizu4fCxR
	VIJ3vr5G0bQYKNig7F2LubAMvywPgXRl6oqfqN7qAZfcFg/dS6vnIv1zYXZyzpb4
	wU6VY1BLNWIAq23TY1dDFy772y8fdWnRqUOcJkoYsAYTf3U5hyv6GW3I+dC+xyD7
	TVdE0IEiDP2jyUX2FgFI4FMKyD36qJdc/qmxFjZg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31bymk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:17:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7GO9k002381;
	Mon, 20 Oct 2025 09:17:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej4ruj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:17:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59K9Hb9C58196394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 09:17:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 360AE20043;
	Mon, 20 Oct 2025 09:17:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E66C020040;
	Mon, 20 Oct 2025 09:17:36 +0000 (GMT)
Received: from osiris (unknown [9.111.49.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Oct 2025 09:17:36 +0000 (GMT)
Date: Mon, 20 Oct 2025 11:17:35 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Josephine Pfeiffer <hi@josie.lol>
Cc: agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] s390: ptdump: use seq_puts() in pt_dump_seq_puts()
 macro
Message-ID: <20251020091735.24715A05-hca@linux.ibm.com>
References: <20251018170521.3355738-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018170521.3355738-1-hi@josie.lol>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bZ9wgrrJA0GouusrPaIBnzRzQTdwpKrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwdp7Fcg3u9/r
 Tx/QvK+o+1uCEqtSbTPpGMrSOFtmueamxFaOJVxXcbHvNzqVUisFl1kX18hpyuIMtIiAgLQA8Jc
 tJN1g6oe1hlvmhGbraFL1/4med4sjDZFGtiMJBxSNR91ureUQtIHgkbi8tAKZrV1rqULSzp16Yr
 iThxa687hV/70iz6fsyUjzV400h7R98A+KsfnJ3/BmuK0H9qoDh7wJ3kJ4PCxYjgIALV+1djwQj
 E8w6Uwpb71lR3BiC4APdiZ11u5qkf293I+3V2HCvuTnHGxtIbdZKJTwvQmPVOP6qt3xGnW9II/J
 oVLek3sZSkECKC2qUx4L+o4VlssdmnQ1OmjWDXvbFwpIbGJKE+UeH1/gN2qojDBK0+ahcc1HLKN
 qODzxVGnxJ0gNcTRE2wUx53gr+Iujg==
X-Proofpoint-GUID: bZ9wgrrJA0GouusrPaIBnzRzQTdwpKrB
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f5fe35 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6jiyLf937yJjbL3lZ8UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Sat, Oct 18, 2025 at 07:05:21PM +0200, Josephine Pfeiffer wrote:
> The pt_dump_seq_puts() macro incorrectly uses seq_printf() instead of
> seq_puts(). This is both a performance issue and conceptually wrong,
> as the macro name suggests plain string output (puts) but the
> implementation uses formatted output (printf).
> 
> The macro is used in dump_pagetables.c:67-68 and 131 to output
> constant strings. Using seq_printf() adds unnecessary overhead for
> format string parsing.
> 
> This bug was introduced in commit 6bf9a639e76e1 ("s390/mm,ptdump: make
> page table dumping seq_file optional") in 2020, which explicitly stated
> it was the "s390 version of commit ae5d1cf358a5 ("arm64: dump: Make the
> page table dumping seq_file optional")", copying the buggy arm64
> implementation.
> 
> Fixes: 6bf9a639e76e1 ("s390/mm,ptdump: make page table dumping seq_file optional")
> Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
...
> -		seq_printf(__m, fmt);		\
> +		seq_puts(__m, fmt);		\

So yes, it should have been seq_puts() instead of seq_printf(), but
there really is no _bug_ here, except of wasted CPU cycles for a seq
file which isn't enabled in any production kernel.

I'll apply this and change the commit message accordingly.

Thanks!
