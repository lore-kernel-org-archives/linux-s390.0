Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5231E85D;
	Mon, 13 Apr 2026 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083314; cv=none; b=qBY8meaDS6PNpd6sC1gb0m1HXMHz3zVudE5Js1vx0ddCVqEhKCnxvwUcod+KJheYY+ayFnGeZc11afu+c1TMNdZmdY6d4qxS07yIF8ItLpCDA+k13p45A4S0hLD8mlpA12SjXMAzau9zdku1HCPLx66GM3k4sk1DWASdIubbZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083314; c=relaxed/simple;
	bh=KyO8N3JLZNTjJwCdP6JYudh2qkkIj3/eiiuu0ydMkfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roezP/XR5eClwtgVVAyGwPBZTmcDUAttuXV7KVarastI49tyzOP3FWPSv1L7ltK6gMFdYRnt4CSEpHrhH+bvH9jfs1nd8iHh/CoDE1dyOGi9Uy3Bo7Ed1Fxl5i2oRjbHbz8aMt+NLWOue05Pc8uQVm3n+tHJS5PUNcvAeq3FMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2wHaZML; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2wHaZML"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D8IW3H1623674;
	Mon, 13 Apr 2026 12:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KyO8N3
	JLZNTjJwCdP6JYudh2qkkIj3/eiiuu0ydMkfk=; b=U2wHaZMLlibBJIv+SwUqau
	kkEa9D/Nqt+q3JJ+ePweOf0Siq/94B27y72y+G2qhumZWEQzlIamYx/rrQvGHQlD
	GtQGNKo2PJa7Vn8YWt5sQe9PUkW/sIfPygF3fyBgLsFNMHw2xyby5U+23fbH2xwO
	65zXUkqlCc0QhUsEIlQaTsNd6bloIHM5aPGsAid5Zw4YavdlUXH0yd/cuXPmDCv0
	8ZGkA88c0ou67HyQ19C8bZeVqjjxS4uzqQUJRgqoqyqEP8QqbY3qr+tr1idASj1A
	c0Io7a0bCW715fqF70XTiGNjHCScTSEGjAJCjZfcwDU2Yg0Soj3+XjMp3IzY9GmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfcqeya3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 12:28:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D8vfkT003557;
	Mon, 13 Apr 2026 12:28:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn534e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 12:28:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DCSO6E41615850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 12:28:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CB8C20040;
	Mon, 13 Apr 2026 12:28:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA63F20043;
	Mon, 13 Apr 2026 12:28:23 +0000 (GMT)
Received: from [9.111.7.85] (unknown [9.111.7.85])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 12:28:23 +0000 (GMT)
Message-ID: <3eec3725-91ae-48e4-a370-9c1bdd7693a2@linux.ibm.com>
Date: Mon, 13 Apr 2026 14:28:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/12] KVM: s390: Changes for 7.1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, david@kernel.org, borntraeger@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20260413104721.203024-1-frankja@linux.ibm.com>
 <CABgObfaWO3J89sFmu3ZBPTztXcKgXPZu3FyiRcasejS=0tgJYQ@mail.gmail.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <CABgObfaWO3J89sFmu3ZBPTztXcKgXPZu3FyiRcasejS=0tgJYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEyMSBTYWx0ZWRfX+vwPABGRtIP2
 /CfeHjR/t9HWs5JfA1Z6JhC+YFBzGj/iSQ3FPNzHlblYSsHcgkikEZVJ9qASTs4gTr2wkZvKm8i
 phS2lHvTLA7hN+NsFVUFP5yfsnxdnjXakishPt+jJLarlbVyv2fIPi57QNT3RrOcA2iLUbt4135
 nWTbhNbs3s9R8ymtFjtceQOrMq/Gg7szj9uw6jAELR+k3rSI/umCK2xfWhC6C7hLAPeImZHwDt8
 He+bmqOm5MqKAd1m5m/yYTFpXiZ0kXTI+nloCt2VuhKbzC2Rn3mWezjSYantbuofbTR5PlO1ZXt
 XctUYPJwuKRfOV3VzP85caJv+d9yUaQdwuDPPnZfdSvBMeWqoUYaPQZwtsSnevCUQM8/UpeIq3V
 mt91EUfy20cCcCFiGLBL2s+3EryXBb+MPS8+uiXVYKbvZ1lhmtknrTedsClr6ttD7Dh4n7syFIf
 wpiMnE7pI8vRmBwNgnw==
X-Proofpoint-GUID: GnGnfWcgFanRzSUIFtUQ60tPSvebn8-8
X-Proofpoint-ORIG-GUID: GnGnfWcgFanRzSUIFtUQ60tPSvebn8-8
X-Authority-Analysis: v=2.4 cv=YemNIQRf c=1 sm=1 tr=0 ts=69dce16c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=EuZqkWixEsUEt_BPA98A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130121

T24gNC8xMy8yNiAxMzoyMywgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gT24gTW9uLCBBcHIg
MTMsIDIwMjYgYXQgMTI6NDfigK9QTSBKYW5vc2NoIEZyYW5rIDxmcmFua2phQGxpbnV4Lmli
bS5jb20+IHdyb3RlOg0KPj4NCj4+IEhleSBQYW9sbywNCj4+DQo+PiBoZXJlIGFyZSBvdXIg
Y2hhbmdlcyBmb3IgNy4xOg0KPj4gLSBDbGF1ZGlvIGlzIGZpbmlzaGluZyB1cCBnbWFwIHdv
cmsgYnkgYWxsb3dpbmcgNGsgbWVtc2xvdHMNCj4+IC0gRXJpYyBhbmQgSGVuZHJpayBhZGRl
ZCBuZXN0aW5nIEVTQSBzdXBwb3J0DQo+PiAtIEkndmUgZml4ZWQgdXAgTFBTVy9FIGVtdWxh
dGlvbiwgZ29pbmcgdGhyb3VnaCBuZXh0IGFzIEkgZG9uJ3QgZXhwZWN0DQo+PiAgICB1cyB0
byBldmVyIGhpdCB0aGlzDQo+Pg0KPj4gVGhlcmUncyBiZWVuIHR3byBjb25mbGljdHMgYmVj
YXVzZSA3LjAgcmVjZWl2ZWQgYSBudW1iZXIgb2YgZ21hcCBmaXhlcy4NCj4gDQo+IFRoaXMg
aXMganVzdCBuZWFyYnkgbGluZXMgYmVpbmcgdG91Y2hlZCwgSSB0aGluaz8gTm8gcmVhbCBj
b25mbGljdC4NCkl0J3MgY29kZSB0aGF0J3MgbWlzc2luZyBpbiBuZXh0IHNpbmNlIHdlIGhh
ZCBhIGxvdCBvZiBjaGFuZ2VzIGluIA0KbWFzdGVyLiBPbmUgaXMgYSBjb25mbGljdCB3aGVy
ZSB0aGUgbmV4dCBsaXN0IG9mIHNlbGZ0ZXN0cyBkb2VzIG5vdCANCmluY2x1ZGUgdGhlIGly
cSByb3V0aW5nIHRlc3QgdGhhdCBJIGFkZGVkIGluIGt2bS1zMzkwLW1hc3Rlci03LjAtMS4g
SS5lLiANCnRyaXZpYWwuDQoNClRoZSBvdGhlciBpcyBfX2dtYXBfbGluaygpIHRoYXQncyBp
bnRyb2R1Y2VkIGluIGEgZml4IGJ1dCBpcyBub3QgYXJvdW5kIA0KeWV0IGZvciA0MjA0MDY3
Zjk5ODIwIGluIG5leHQuDQo=
