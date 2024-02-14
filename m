Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4D125A1;
	Wed, 14 Feb 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898489; cv=none; b=hGn7RtSsdyfVhaGH9yFt07rmbA4C06kG7bxYbzUx615ZRWM6YUsRwDWjbQEYi9nykbRZNEEdt7ax58heNC/gryLubXuMCEpAmTL+kOvTocdORyMllbq3Vx9pRBuxGI0QGGyszcieNBQ4e5qV87Fr10euICbMhHtjKGn/OAqu/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898489; c=relaxed/simple;
	bh=E58sshtQGGAtboNAyXRHqezkJGXG/S9g6ryjwtUGHXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQeZi+bsp2S4FdN6zFnG9q1KXDAAZMHNUHOPy0sWBaB/4yH3NUrzetfZt7saf1mUj88iBTsu7oQ3QX0Wtn6ttWZvBzwQPBW9aE84mWsduWLMh7ia2WWegZ9Hoj+4XFINrdNv8Tw/DLEWGG476w1JrghALAP3vBRvufk/NiJRU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wsx4rL87; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wsx4rL87"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E6vMcE024406;
	Wed, 14 Feb 2024 08:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=E58sshtQGGAtboNAyXRHqezkJGXG/S9g6ryjwtUGHXo=;
 b=Wsx4rL87Z1jA5kVxuV6Z9gUZtccrUBTLdF5tQauaVHcq9GFKVhXR/c2Jxwt0cQHkoif1
 4Vnk7h1hpA87pc/t036q8cqHwFX4CyDPi5Nd4B7/VR6O5NkIwxfHM74XpmUV95xbMUo8
 dZN3DwB5hJ73ma+9rm3b+CzW6NavlFWZGaW3NMiyXmbNo0K5+kgPWFnOfcGHCIGR7DmP
 CZgXxedE6KmDDhfuUFP7PeSo/EvkV84EicvsOMRZrcsN2wEYdZ9jal9wIzDoU9JH2Ljb
 Og4b/LCN7klEMWcKyDUmBXlM0ca/JaUK4TvW2wN2ZiAa9ixz0fwJn86/+ZfB+Zk3Trui dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8rpx1urq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 08:14:42 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41E7teQD016940;
	Wed, 14 Feb 2024 08:14:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8rpx1ur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 08:14:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41E4rsqL009886;
	Wed, 14 Feb 2024 08:14:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62v6sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 08:14:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41E8EY1T15860120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 08:14:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB88320071;
	Wed, 14 Feb 2024 08:14:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B748E20063;
	Wed, 14 Feb 2024 08:14:33 +0000 (GMT)
Received: from [9.171.13.26] (unknown [9.171.13.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 08:14:33 +0000 (GMT)
Message-ID: <7e387643370020483fb53f2c1e9dfd2b9ba28818.camel@linux.ibm.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim
 SOCK_DBG bit.
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller"
	 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts
	 <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Wenjia Zhang
	 <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Wen Gu
	 <guwen@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        "D . Wythe"
	 <alibuda@linux.alibaba.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, linux-s390@vger.kernel.org
Date: Wed, 14 Feb 2024 09:14:33 +0100
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
References: <20240213223135.85957-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xnQ485-_AsK7TDTFizgRdpnprTUkpf1b
X-Proofpoint-ORIG-GUID: G8hDWlTEhwhkphYOtKdHNzbM1YZcjRGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140062

T24gVHVlLCAyMDI0LTAyLTEzIGF0IDE0OjMxIC0wODAwLCBLdW5peXVraSBJd2FzaGltYSB3cm90
ZToKCkhpIEt1bml5dWtpLAoKSSdtIGFkZGluZyB0aGUgbmV3bHkgYXBwb2ludGVkIFNNQyBtYWlu
dGFpbmVycyB0byBjaGltZSBpbi4KCj4gUmVjZW50bHksIGNvbW1pdCA4ZTU0NDNkMmI4NjYgKCJu
ZXQ6IHJlbW92ZSBTT0NLX0RFQlVHIGxlZnRvdmVycyIpCj4gcmVtb3ZlZCB0aGUgbGFzdCB1c2Vy
cyBvZiBTT0NLX0RFQlVHKCksIGFuZCBjb21taXQgYjFkZmZjZjBkYTIyCj4gKCJuZXQ6Cj4gcmVt
b3ZlIFNPQ0tfREVCVUcgbWFjcm8iKSByZW1vdmVkIHRoZSBtYWNyby4KPiAKPiBOb3cgaXMgdGhl
IHRpbWUgdG8gZGVwcmVjYXRlIHRoZSBvbGRlc3Qgc29ja2V0IG9wdGlvbi4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBLdW5peXVraSBJd2FzaGltYSA8a3VuaXl1QGFtYXpvbi5jb20+Cj4gLS0tCj4gwqBp
bmNsdWRlL25ldC9zb2NrLmjCoCB8IDEgLQo+IMKgbmV0L2NvcmUvc29jay5jwqDCoMKgwqAgfCA2
ICsrKy0tLQo+IMKgbmV0L21wdGNwL3NvY2tvcHQuYyB8IDQgKy0tLQo+IMKgbmV0L3NtYy9hZl9z
bWMuY8KgwqDCoCB8IDUgKystLS0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvc29jay5jIGIvbmV0
L2NvcmUvc29jay5jCj4gaW5kZXggODhiZjgxMDM5NGE1Li4wYTU4ZGM4NjE5MDggMTAwNjQ0Cj4g
LS0tIGEvbmV0L2NvcmUvc29jay5jCj4gKysrIGIvbmV0L2NvcmUvc29jay5jCj4gQEAgLTExOTQs
MTAgKzExOTQsOSBAQCBpbnQgc2tfc2V0c29ja29wdChzdHJ1Y3Qgc29jayAqc2ssIGludCBsZXZl
bCwKPiBpbnQgb3B0bmFtZSwKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKG9wdG5hbWUp
IHsKPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBTT19ERUJVRzoKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLyogZGVwcmVjYXRlZCwgYnV0IGtlcHQgZm9yIGNvbXBhdGliaWxpdHkuICov
Ck5vdCAxMDAlIHN1cmUgYWJvdXQgdGhlIGxhbmd1YWdlIC0gYnV0IGlzbid0IHRoZSBERUJVRyBm
ZWF0dXJlCipyZW1vdmVkKiByYXRoZXIgdGhhbiBqdXN0ICpkZXByZWNhdGVkKj8KCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodmFsICYmICFzb2Nrb3B0X2NhcGFibGUoQ0FQ
X05FVF9BRE1JTikpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0ID0gLUVBQ0NFUzsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxz
ZQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc29ja192
YWxib29sX2ZsYWcoc2ssIFNPQ0tfREJHLCB2YWxib29sKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIFNPX1JFVVNFQUREUjoK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNrLT5za19yZXVzZSA9ICh2YWxib29s
ID8gU0tfQ0FOX1JFVVNFIDoKPiBTS19OT19SRVVTRSk7Cj4gQEAgLTE2MTksNyArMTYxOCw4IEBA
IGludCBza19nZXRzb2Nrb3B0KHN0cnVjdCBzb2NrICpzaywgaW50IGxldmVsLAo+IGludCBvcHRu
YW1lLAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAob3B0bmFtZSkgewo+IMKgwqDCoMKg
wqDCoMKgwqBjYXNlIFNPX0RFQlVHOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2
LnZhbCA9IHNvY2tfZmxhZyhzaywgU09DS19EQkcpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAvKiBkZXByZWNhdGVkLiAqLwpTYW1lIGhlcmUuCgo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB2LnZhbCA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBicmVhazsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIFNPX0RPTlRST1VURToKPiBkaWZm
IC0tZ2l0IGEvbmV0L21wdGNwL3NvY2tvcHQuYyBiL25ldC9tcHRjcC9zb2Nrb3B0LmMKPiBpbmRl
eCBkYTM3ZTQ1NDFhNWQuLmY2ZDkwZWVmM2Q3YyAxMDA2NDQKPiAtLS0gYS9uZXQvbXB0Y3Avc29j
a29wdC5jCj4gKysrIGIvbmV0L21wdGNwL3NvY2tvcHQuYwo+IEBAIC04MSw3ICs4MSw3IEBAIHN0
YXRpYyB2b2lkIG1wdGNwX3NvbF9zb2NrZXRfc3luY19pbnR2YWwoc3RydWN0Cj4gbXB0Y3Bfc29j
ayAqbXNrLCBpbnQgb3B0bmFtZSwgaW4KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc3dpdGNoIChvcHRuYW1lKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjYXNlIFNPX0RFQlVHOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc29ja192YWxib29sX2ZsYWcoc3NrLCBTT0NLX0RCRywgISF2YWwpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogZGVwcmVjYXRlZC4g
Ki8KYW5kIGhlcmUuCgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FzZSBTT19L
RUVQQUxJVkU6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKHNzay0+c2tfcHJvdC0+a2VlcGFsaXZlKQo+IEBAIC0xNDU4LDggKzE0NTgsNiBAQCBz
dGF0aWMgdm9pZCBzeW5jX3NvY2tldF9vcHRpb25zKHN0cnVjdAo+IG1wdGNwX3NvY2sgKm1zaywg
c3RydWN0IHNvY2sgKnNzaykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNrX2Rz
dF9yZXNldChzc2spOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBz
b2NrX3ZhbGJvb2xfZmxhZyhzc2ssIFNPQ0tfREJHLCBzb2NrX2ZsYWcoc2ssIFNPQ0tfREJHKSk7
Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaW5ldF9jc2soc2spLT5pY3NrX2NhX29wcyAhPSBp
bmV0X2Nzayhzc2spLT5pY3NrX2NhX29wcykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHRjcF9zZXRfY29uZ2VzdGlvbl9jb250cm9sKHNzaywgbXNrLT5jYV9uYW1lLCBmYWxzZSwK
PiB0cnVlKTsKPiDCoMKgwqDCoMKgwqDCoMKgX190Y3Bfc29ja19zZXRfY29yayhzc2ssICEhbXNr
LT5jb3JrKTsKPiBkaWZmIC0tZ2l0IGEvbmV0L3NtYy9hZl9zbWMuYyBiL25ldC9zbWMvYWZfc21j
LmMKPiBpbmRleCA2Njc2M2M3NGFiNzYuLjA2MmUxNmEyNzY2YSAxMDA2NDQKPiAtLS0gYS9uZXQv
c21jL2FmX3NtYy5jCj4gKysrIGIvbmV0L3NtYy9hZl9zbWMuYwo+IEBAIC00NDUsNyArNDQ1LDYg
QEAgc3RhdGljIGludCBzbWNfYmluZChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3QKPiBzb2Nr
YWRkciAqdWFkZHIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKDFVTCA8PCBTT0NLX0xJTkdFUikgfCBcCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTCA8PCBTT0NLX0JS
T0FEQ0FTVCkgfCBcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKDFVTCA8PCBTT0NLX1RJTUVTVEFNUCkgfCBcCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMIDw8IFNPQ0tf
REJHKSB8IFwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAoMVVMIDw8IFNPQ0tfUkNWVFNUQU1QKSB8IFwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMIDw8IFNPQ0tfUkNW
VFNUQU1QTlMpIHwgXAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICgxVUwgPDwgU09DS19MT0NBTFJPVVRFKSB8IFwKPiBAQCAtNTExLDgg
KzUxMCw4IEBAIHN0YXRpYyB2b2lkIHNtY19jb3B5X3NvY2tfc2V0dGluZ3NfdG9fY2xjKHN0cnVj
dAo+IHNtY19zb2NrICpzbWMpCj4gwqAKPiDCoCNkZWZpbmUgU0tfRkxBR1NfQ0xDX1RPX1NNQyAo
KDFVTCA8PCBTT0NLX1VSR0lOTElORSkgfCBcCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTCA8PCBTT0NLX0tFRVBPUEVOKSB8IFwK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICgxVUwgPDwgU09DS19MSU5HRVIpIHwgXAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTCA8PCBTT0NLX0RCRykpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMIDw8IFNP
Q0tfTElOR0VSKSkKPiArCj4gwqAvKiBjb3B5IG9ubHkgc2V0dGluZ3MgYW5kIGZsYWdzIHJlbGV2
YW50IGZvciBzbWMgZnJvbSBjbGMgdG8gc21jCj4gc29ja2V0ICovCj4gwqBzdGF0aWMgdm9pZCBz
bWNfY29weV9zb2NrX3NldHRpbmdzX3RvX3NtYyhzdHJ1Y3Qgc21jX3NvY2sgKnNtYykKPiDCoHsK
VGhlIFNNQyBjaGFuZ2VzIGxvb2sgZ29vZCB0byBtZSwgc28gZmVlbCBmcmVlIHRvIGFkZCBteQpS
ZXZpZXdlZC1ieTogR2VyZCBCYXllciA8Z2JheWVyQGxpbnV4LmlibS5jb20+Cg==

