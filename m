Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE5233923;
	Tue, 19 May 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191853; cv=none; b=WX8woOkLdpeVYAEoLefKs/Mgy15gzaJXWs86X19R3DYaDbDGGkF4eJzeOC5DFNfzxGxTph8EI4YUieKESSxQC42lwt5x1Py924bYku+DR/cIrT8lP2O5k1RlfYEKBo9fu9F9AI/P2Dx/rK9PebXOIZNhPawto/EZlevSfWjfq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191853; c=relaxed/simple;
	bh=6EZCHMVdS597wOLUO7ZPzyllgxXwJURdG86Fos2O5Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPWnGNvfcMJOFst+HboEhfREBHemZoJXRr4aqbuVCe54qqgeF016hqtdcUD02QMDkDt8nmG1RSoYtGIEKvb22iF7LCmzBcKAX1XcuEfsohL8Ce8E0YRUWjvIM15mKHKd1umtSeo4O/ERCqgVCUxORmpqtisAg1v4SL6k4xcg0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kBgFCXbI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kBgFCXbI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JALemx4104744;
	Tue, 19 May 2026 11:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A35f61
	6ximyD2l1IRGEAPtIdQwj5Xn7kqj/nig58Ri8=; b=kBgFCXbICrhcTC8Kv3mre1
	QPBS2lgIFjjFa5V06r8kYmXjdnsAKGrr7cN8q4Po9hDhSeiDluhgvQraMXUw7Ff2
	coOahURYVQsJniyee6JTPeIPSO2nxHpzfq2zkVHxB5yUtFYmAgc7tBzoIbLddJW/
	foBaiXFNHHnr9jOmdIKG1pB3wBG0ddXuzeHuuwoi88wfW+5UXJDlMw0LHxcKOfci
	K64L8mI4ISL8GZr36HzA1jYEHWW4RIgcUx4AZ2feVPzRqgYZZp6FUMzPdxervuZ1
	e8/UIoVkpNPGAVxNo76JF+lWIiQd6eIYvRP9mHa0Oj5Lg9hOQvAjC5R3Syo3JuJQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xvsw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:57:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JBs5Q4022803;
	Tue, 19 May 2026 11:57:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq2kvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:57:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JBvP8640632586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 11:57:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 244E720043;
	Tue, 19 May 2026 11:57:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDAE020040;
	Tue, 19 May 2026 11:57:24 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 11:57:24 +0000 (GMT)
Message-ID: <b12aff92-e65d-4d86-af4f-3afd19605961@de.ibm.com>
Date: Tue, 19 May 2026 13:57:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] KVM: s390: Properly reset zero bit in PGSTE
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
 <20260512175251.300882-6-imbrenda@linux.ibm.com>
 <0f114ba1-72f6-4ffb-b179-01b8baaaec4c@de.ibm.com>
 <20260519133836.0d344247@p-imbrenda>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260519133836.0d344247@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExNSBTYWx0ZWRfX+HTHtMc55MnX
 rD81FgQMWsb8zqkWEuXeH/pCALRuKSoO1seFQ4jDMEagvcColwp1WYhIIbfS5/ZwUNaeayev8Qt
 Ljd9M6oXB27KlaN7EmczeGLvRc3/VvFjnACmYB1xmsXqbv6J9QbHUppOayCdxwFUtYkXi6wZDat
 xYehAv54FrmMoPATYC35cicRJLwGlHjEm68T8PjziMVQB4wCGoZKJOvwKoVWI4xSyL+8HSJLYGQ
 swVDKsr4kIU70ZeCBp9YigkZVQmW1mLnAhpPXEarWksZDWOE0czyk+kMyvJDL6WniGcATM05aqX
 0xH72M6I0yA3Tm1jzs+55Z3SKe6Bkasv9duVbTB9vi6+9fkw0CdvECZZvl9O6F9L6DRohoUBsaN
 1XbNq6mdv4+0zJRdCoT90NW5nFX0ZqjxFsTv+LotlwMAEo2mSGgK2T67HHDTS9xAxDJciYWr14n
 Qt4yxMCEX3GB7gYKHGA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0c5029 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=RguYKKiWQpcrlkvWGWkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4bXi4EVMmhJTLhP-WCdc7aITie_VuIFz
X-Proofpoint-GUID: 4bXi4EVMmhJTLhP-WCdc7aITie_VuIFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190115

Am 19.05.26 um 13:38 schrieb Claudio Imbrenda:
> On Mon, 18 May 2026 13:44:45 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
>>> When calling _gmap_ptep_xchg(), always clear the pgste.zero bit. This
>>> prevents the page from being accidentally discarded when getting
>>> unmapped.
>>
>> Ideally have some example in the patch description, that makes review easier.>
> 
> will do
> 
>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
>> Was this broken before the rework as well? Do we need a stable backport into 6.19
>> and older?
> 
> no, this breakage is a product of the gmap rewrite

Then please add a Fixes tag.
