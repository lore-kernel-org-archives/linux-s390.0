Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D51A6829;
	Wed, 12 Aug 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561831; cv=none; b=tSqfoJyXfJAf6xdY9g7WOg9AgYyFBmrig8yG7ZsWNaXXon74V4rsdZW9fzEw4ma/umNBLlP+OWqQ5+GwG4q72GeosfBUmsl/yLg2iFBgEtnLEObkTS8436ogxelND0E31wsQYqImgiu0uB2KbA7LPGW9HdcUSUqqoAm3oV9CnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561831; c=relaxed/simple;
	bh=AyLPSpkkJWVT77gDkMjAG07q5Cb22cPzrExJa0F24yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC+iwILBU7chtniepZls0zRNmIhfC221aEpKHo5zazULjE+E96GjD4DAD0RBAV4CoPKBNlWgGzfG28tI9+6TIxXbiiqH3PDDgEzZtkxdUQdOWphyIq5mO0i/NJv3X6AfT4oZ404VJnxwv0Qh5qzP8tA7cmxhQ+Y1wA441+hc4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ngQhZAS/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ngQhZAS/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1h9r4088626;
	Wed, 12 Aug 2026 19:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pwcoCQ
	nbq0REWFMayQisvzo2rMnjQmR5OVseOJnQLws=; b=ngQhZAS/sKqjFjlYP5ldpW
	w6ryu6EhHIrSo/XXvwFfWfUFsntqeBigRuvEZB96NWcwe7vKz5gdGZdcN6GenB6u
	l6wvbWGN+r+j/o0y+dcVJiD3hbuO4pDwUQO/N9h+r2SYiv7pWCV7QcA1vqOpVYls
	g12FP+MvT+zY6tFUJpxDJzgahMycV5wYcDXw7HFreegQ7SfJSSLxKwRvmVCGY9Jw
	SfyEespct2/0MIF2ooMQdm5SN+rPOHdJuWeWd9PPHhu+EodnZ6EbhTlA4oQHsYsS
	cTbetsvDikjegkNb8CDQ798HjDxjB8iuhI2Fd0qntQAdetzMxjzDht56lezJXUtQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9v9qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 19:10:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIuMDD020038;
	Wed, 12 Aug 2026 19:10:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq7rfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 19:10:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CJA5ju34996552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 19:10:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6D882004B;
	Wed, 12 Aug 2026 19:10:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D8720040;
	Wed, 12 Aug 2026 19:10:04 +0000 (GMT)
Received: from [9.87.128.143] (unknown [9.87.128.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 19:10:04 +0000 (GMT)
Message-ID: <5af0855a-4d2f-496d-9752-340519e02ba6@linux.ibm.com>
Date: Wed, 12 Aug 2026 21:10:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/33] KVM: s390: gmap: Make prefix handling optional
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-22-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-22-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE1MyBTYWx0ZWRfX1yldEPMDpfEq
 bVsYfrQrAlvGnum03JUhnu6qbsMx1Nu98jwyZ53eEwHL8bW29PLRF1VQ0XdWsgDoCtkGM/drtcG
 ky53Bn/wKooAjhTdGiU19ZjA1rKV6nB7gnOK17aeDyO/SO+yqeNQkFkUYvrcDN217Wfi1+9zDo1
 zyKmgVXgfCK7qxu4CJzcR+1mls5c9hCtpYKxX5giM/QsEC3knQuLb5Ubn9qtUkwkx6Q1YjoOx11
 Dh0Su+0SMSlVCPaQs5AvY62X+LYuJjKMRw+L/orRXexTdQCodIrIr6yqULMS+gGeMgQM2flLpjQ
 CsIWhD5zJzCxRGF12iRZ66jq6q5Akds0Fa5UCjRVlrRQkx82CeqeVX9BC0jCs+uQaSGhTuzSSpu
 zP1k5/eO/OkGywK7mldKbozZKb7JWtzaXksBTmf9du0q/x7rLkO8UDc2lDtXPcF4wL1LTirLHoG
 EAc74CRXaqlcWleg30Q==
X-Proofpoint-ORIG-GUID: fEtqQam0vsVp8mEFO6iLZx4iIkRjwFmt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE1MyBTYWx0ZWRfX5bSQcEJMRDg3
 wqDoTDQbpUC7eUsDsMB5inXmf6FrnlyXdNO9k4BqIhDH5aSi2OnRZQEfIhxYuYuF2ZDNJlpQALn
 ZEFQ8YkCvR89cpQU2OoxqLiAQMaeQOQ=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cc513 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=yNxp-bOO0t2THUwMnkwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: F_qHovdzNRk82HcCXNqCDh2Un5GpxvKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120153

Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Guard guest prefix handling behind `KVM_S390_MANAGES_S390_GUEST`. This
> enables other KVM implementations to use gmap without implementing
> prefix handling. The prefix handling is integrated deeply in the gmap
> implementation. Therefore, provide safe default implementations for the
> guarded functions.
> 
> No functional changes.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

