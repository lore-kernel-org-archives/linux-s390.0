Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BF399348
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876322; cv=none; b=SyuLMLL+Gq/n166V9/g0n49b5MVcfWpNvDG5cO/acCpC4bf2kJH2Yvpol5IBmitupnw8NuXdKq2dgIe6e7xaCmEE6F7bxeD+UpzGFbOBapyPAmDBzaU7hB4COUQKeQjExb3D6cIHKa7m/RhhApkR18w9+4s4KmpA6swzo+JgCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876322; c=relaxed/simple;
	bh=H1PNZOxf7KS0vnzq0F3qxVag2NAOr48DutHIz7UFCmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdcIXbqirf/o4NthVfEAmMC5x6Hz1eM+MQc7AkboG5+9dNl/iG6c370grWeJApnldyArN6jM7KUTF9iKZftYfP6a4Htaig/LSfLD0H6iAx7OKiFwXOlY6CNKmdmGYKdcX5UAzO0rMKINi+PAW3DTl8mtUb7mxVnkCTQzMMOLsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sdOydHEV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sdOydHEV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5BrQS920034;
	Fri, 24 Jul 2026 06:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H1PNZO
	xf7KS0vnzq0F3qxVag2NAOr48DutHIz7UFCmQ=; b=sdOydHEV5I7AZYIrNwQkj+
	hlceBL/0IBcjfx27rhVFvXXJzGuFvbT5sbqAABXUscl7ZaMADON1x3O0+E1hi153
	l+ErbzegQU2AAruy2JMFmry7+evvrI20m7NfYqoceLw1QY+HWeB3NDYbYyDna/r2
	xns41wT+nGvKZUixAD3mRCPGF0umT4koSdCFG7jOjRgM/q0r2aYZgkjU6zZtgy1f
	kndrYdqbfJ0h2qeYn0a2OhPd9a7DoGgG8+JuVTrfsYqY8+UJStRROO/sRqIThTXV
	G33KtQJZqMyJAhxUw7CnCCAIhh/w9+m6EbQ/bIi6CGTucqJr06jKC0XNwfEDIS9w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791bf4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:58:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O6Yhvj031275;
	Fri, 24 Jul 2026 06:58:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahfs8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 06:58:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O6wX5I34079080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 06:58:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D885120114;
	Fri, 24 Jul 2026 06:58:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6E8E20112;
	Fri, 24 Jul 2026 06:58:33 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 06:58:33 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Ciunas Bennett <ciunas@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Subject: Re: [PATCH v2 2/2] s390/kvm: Add tracepoint for DIAG 9c directed
 yield operations
In-Reply-To: <4780639c-c5f1-474d-b51c-df9126ee6a1c@linux.ibm.com>
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
	<20260625131615.262367-3-ciunas@linux.ibm.com>
	<71e16596-591a-4991-b217-ecdcf284ea67@linux.ibm.com>
	<4780639c-c5f1-474d-b51c-df9126ee6a1c@linux.ibm.com>
Date: Fri, 24 Jul 2026 08:58:33 +0200
Message-ID: <yt9dse583mcm.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GEMJqroaSPpCzczCHY6kxqVfEoe-K9gA
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a630d1f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=PYSegd_rVISg_iv6bqgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX+4uZGxOpsg8y
 n7s0NQxSopE06IJ+xP7pY4uLItOgJYzhbNc94fyFWiXotWeqjAxxANR115RE2ZlxR5GHRYS5lgg
 tgLIbVRNP+Qz+izb6UpNMlUQjOsVKCI=
X-Proofpoint-GUID: GEMJqroaSPpCzczCHY6kxqVfEoe-K9gA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1OSBTYWx0ZWRfX4lEbIef5VxAg
 5CYS//0Y6li3zjXOpOgtNAOaAVllVQz6NyhFno1N5DhNPaRoqXqG+4Okwm6yC5uqhEFuCX2j2CT
 QdL3FgaV4x/tvAhmXX0PB8Lo74nBhUpfKxKRoosi+shnNXyOLtIWdCr+jD65TYnntBGspP15sYi
 TL34T7nGL8eHxRtZas6+y/GLImLJvi5ouC8PHfVzUb1ErkJAyMN8j4nCEcU12MtZvPeWEnkacQO
 oE40eSSxz+RhYtBCie+sDwKFgpTvEjh38oaf6kauKghQqR5pdJ15fQgmaEKVE50B32dixsPiVbT
 3twlY49AQVwgcFT2ehY+vokjoT+ySy+6kGvgPolS1dEf+w4xn/LyAOeBdpZs1VJBt9B6q/eRiXq
 h7xg7N4av8Htla/TUOeJSERVRf0VGoc7HKghNOTVlacMfKhTcayrCTwD/TlDiBATX3tkRibPo9n
 2DkH3jlKZn+iTRwkk2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240059

Q2l1bmFzIEJlbm5ldHQgPGNpdW5hc0BsaW51eC5pYm0uY29tPiB3cml0ZXM6DQoNCj4gT24gMjMv
MDcvMjAyNiAxNjoyOCwgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIHdyb3RlOg0KPj4NCj4NCj4gWy4u
Ll0NCj4NCj4+PiArVFJBQ0VfRVZFTlQoa3ZtX3MzOTBfZGlhZ185YywNCj4+PiArwqDCoMKgwqDC
oMKgwqAgVFBfUFJPVE8oVkNQVV9QUk9UT19DT01NT04sIGludCB0YXJnZXRfdmNwdSwgaW50IHRh
cmdldF9jcHUsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpyZXN1
bHQpLA0KPj4+ICvCoMKgwqDCoMKgwqDCoCBUUF9BUkdTKFZDUFVfQVJHU19DT01NT04sIHRhcmdl
dF92Y3B1LCB0YXJnZXRfY3B1LCByZXN1bHQpLA0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqAg
VFBfU1RSVUNUX19lbnRyeSgNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWQ1BVX0ZJRUxE
X0NPTU1PTg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZmllbGQoaW50LCB0YXJnZXRf
dmNwdSkNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKGludCwgdGFyZ2V0X2Nw
dSkNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2ZpZWxkKGludCwgY3VycmVudF9jcHUp
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19zdHJpbmcocmVzdWx0LCByZXN1bHQpDQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKSwNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IFRQX2Zhc3RfYXNzaWduKA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZDUFVfQVNTSUdO
X0NPTU1PTg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZW50cnktPnRhcmdldF92Y3B1
ID0gdGFyZ2V0X3ZjcHU7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19lbnRyeS0+dGFy
Z2V0X2NwdSA9IHRhcmdldF9jcHU7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19lbnRy
eS0+Y3VycmVudF9jcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgX19hc3NpZ25fc3RyKHJlc3VsdCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKSwNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIFZDUFVfVFBfUFJJTlRLKA0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJkaWFnPTljIHZjcHU9JWQgcGNwdT0lZCB0YXJn
ZXRfdmNwdT0lZCB0YXJnZXRfcGNwdT0lZCByZXN1bHQ9JXMiLA0KPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF9fZW50cnktPmlkLA0KPj4gSSB0aGluayB2Y3B1PSVkIHJlLXByaW50
cyBfX2VudHJ5LT5pZCwgd2hpY2ggVkNQVV9UUF9QUklOVEsoKQ0KPj4gYWxyZWFkeSBlbWl0cyBh
cyB0aGUgbGluZSBwcmVmaXg7IGxpa2V3aXNlIGN1cnJlbnRfY3B1L3BjcHU9JWQNCj4+IGR1cGxp
Y2F0ZXMgZnRyYWNlJ3MgYnVpbHQtaW4gcGVyLWV2ZW50IENQVSBjb2x1bW4uDQo+PiBDYW4geW91
IGRvdWJsZSBjaGVjaz8NCj4NCj4gWWVzIGl0IGlzIGFuZCBJIHdhcyBhd2FyZSB0aGF0IFZDUFVf
VFBfUFJJTlRLIGFscmVhZHkgaW5jbHVkZXMgdGhlIHZDUFUgSUQNCj4gaW4gdGhlIHByZWZpeCwg
YnV0IEkga2VwdCBpdCBpbiB0aGUgbWVzc2FnZSBmb3IgcmVhZGFiaWxpdHkuDQo+IEhhdmluZyBh
bGwgdGhlIHJlbGV2YW50IGZpZWxkcyB0b2dldGhlciBpbiBhIHNpbmdsZSBmb3JtYXQgc3RyaW5n
IG1ha2VzDQo+IHRoZSBvdXRwdXQgYSBiaXQgZWFzaWVyIHRvIGdyZXAgYW5kIGZvbGxvdyB2aXN1
YWxseSBJIGZpbmQuDQo+IFRoYXQgc2FpZCwgaWYgeW91J2QgcHJlZmVyIHRvIGtlZXAgaXQgY29u
c2lzdGVudCB3aXRoIHRoZSBvdGhlcg0KPiB0cmFjZXBvaW50cywgSSdtIGhhcHB5IHRvIGRyb3Ag
dGhlIGR1cGxpY2F0ZSB2Q1BVIGZpZWxkLg0KDQpQbGVhc2UgZHJvcCBpdCAtIGl0IHNob3VsZCBi
ZSBjb25zaXN0ZW50IHdpdGggb3RoZXIgdHJhY2Vwb2ludCwgYW5kDQp3b3VsZCBvbmx5IGNvbnN1
bWUgYWRkaXRpb25hbCBzcGFjZSBpbiB0aGUgdHJhY2UgYnVmZmVyLg0K
