Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216291C84BC;
	Tue, 19 Aug 2025 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592991; cv=none; b=QgaaLNlcBIC/mGGds8Lwg596BEK8I27TvmS0U6pW3lrjbD8wtSb0yXATr5JZ3DgYYgjFqBO4gGeFcfN7AitbGFZWzVLJ7E8eG61sD26fDMwLVllB3yw5oHKjSEOZ0r3QZEJPw8o/xYGFzmkRNIpTK2OmO6KkzE8IL3CifTJXzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592991; c=relaxed/simple;
	bh=iAS1FJ+3/bBYDbXw+jqjQPnametpuIDH+UuNcbmJnn0=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=cuOf53IgoL4KZRern+NVHTirgTabep7vB2LegyCV9jCzFQzIllrYf6FIQe9pHG5Q19Ls/Yynu8PMsLvCzxxhUTfOg7hLJhBc1TAUkgmUbxzC3/sRRUzraKyYtrOwZ9ET3IV9LdoCUBbCr6DXDfWqY7EOdsSDmG8zdjlBFs3CIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4c5jlW1k9hz4xNtm;
	Tue, 19 Aug 2025 16:43:03 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 57J8gjhK083087;
	Tue, 19 Aug 2025 16:42:45 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 19 Aug 2025 16:42:47 +0800 (CST)
Date: Tue, 19 Aug 2025 16:42:47 +0800 (CST)
X-Zmail-TransId: 2afb68a439071d3-3bc15
X-Mailer: Zmail v1.0
Message-ID: <202508191642476319esv1sG1oQiHF4o_zNJC0@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.enpei@zte.com.cn>
To: <sth@linux.ibm.com>
Cc: <hoeppner@linux.ibm.com>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
        <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzMzkwL2Rhc2Q6IGNvbnZlcnQgdG8gdXNlIEVSUl9DQVNUKCk=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 57J8gjhK083087
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 19 Aug 2025 16:43:03 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A43917.000/4c5jlW1k9hz4xNtm



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogWmhhbmcgRW5wZWkgPHpoYW5nLmVucGVpQHp0ZS5jb20uY24+DQoNClVzZSBFUlJfQ0FT
VCgpIHNpbmNlIHRoZSBtYWNybyBjbGVhcmx5IGluZGljYXRlcyB0aGF0IHRoaXMgaXMgYSBwb2lu
dGVyDQp0byBhbiBlcnJvciB2YWx1ZSBhbmQgYSB0eXBlIGNvbnZlcnNpb24gd2FzIHBlcmZvcm1l
ZC4NCg0KU2lnbmVkLW9mZi1ieTogWmhhbmcgRW5wZWkgPHpoYW5nLmVucGVpQHp0ZS5jb20uY24+
DQotLS0NCiBkcml2ZXJzL3MzOTAvYmxvY2svZGFzZF9kZXZtYXAuYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvczM5MC9ibG9jay9kYXNkX2Rldm1hcC5jIGIvZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2Rf
ZGV2bWFwLmMNCmluZGV4IGRkYmRmMWY4NWQ0NC4uMGY0OTAwZDI0NmU4IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZGV2bWFwLmMNCisrKyBiL2RyaXZlcnMvczM5MC9ibG9j
ay9kYXNkX2Rldm1hcC5jDQpAQCAtNTU1LDcgKzU1NSw3IEBAIGRhc2RfY3JlYXRlX2RldmljZShz
dHJ1Y3QgY2N3X2RldmljZSAqY2RldikNCiANCiAgICAgICAgZGV2bWFwID0gZGFzZF9kZXZtYXBf
ZnJvbV9jZGV2KGNkZXYpOw0KICAgICAgICBpZiAoSVNfRVJSKGRldm1hcCkpDQotICAgICAgICAg
ICAgICAgcmV0dXJuICh2b2lkICopIGRldm1hcDsNCisgICAgICAgICAgICAgICByZXR1cm4gRVJS
X0NBU1QoZGV2bWFwKTsNCiANCiAgICAgICAgZGV2aWNlID0gZGFzZF9hbGxvY19kZXZpY2UoKTsN
CiAgICAgICAgaWYgKElTX0VSUihkZXZpY2UpKQ0KLS0gDQoyLjI1LjE=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IFpoYW5nIEVucGVpICZsdDt6aGFuZy5l
bnBlaUB6dGUuY29tLmNuJmd0Ozxicj48L3A+PHA+PGJyPjwvcD48cD5Vc2UgRVJSX0NBU1QoKSBz
aW5jZSB0aGUgbWFjcm8gY2xlYXJseSBpbmRpY2F0ZXMgdGhhdCB0aGlzIGlzIGEgcG9pbnRlcjxi
cj48L3A+PHA+dG8gYW4gZXJyb3IgdmFsdWUgYW5kIGEgdHlwZSBjb252ZXJzaW9uIHdhcyBwZXJm
b3JtZWQuPC9wPjxwPjxicj48L3A+PHA+U2lnbmVkLW9mZi1ieTogWmhhbmcgRW5wZWkgJmx0O3po
YW5nLmVucGVpQHp0ZS5jb20uY24mZ3Q7PC9wPjxwPi0tLTwvcD48cD4mbmJzcDtkcml2ZXJzL3Mz
OTAvYmxvY2svZGFzZF9kZXZtYXAuYyB8IDIgKy08L3A+PHA+Jm5ic3A7MSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pPC9wPjxwPjxicj48L3A+PHA+ZGlmZiAtLWdp
dCBhL2RyaXZlcnMvczM5MC9ibG9jay9kYXNkX2Rldm1hcC5jIGIvZHJpdmVycy9zMzkwL2Jsb2Nr
L2Rhc2RfZGV2bWFwLmM8L3A+PHA+aW5kZXggZGRiZGYxZjg1ZDQ0Li4wZjQ5MDBkMjQ2ZTggMTAw
NjQ0PC9wPjxwPi0tLSBhL2RyaXZlcnMvczM5MC9ibG9jay9kYXNkX2Rldm1hcC5jPC9wPjxwPisr
KyBiL2RyaXZlcnMvczM5MC9ibG9jay9kYXNkX2Rldm1hcC5jPC9wPjxwPkBAIC01NTUsNyArNTU1
LDcgQEAgZGFzZF9jcmVhdGVfZGV2aWNlKHN0cnVjdCBjY3dfZGV2aWNlICpjZGV2KTwvcD48cD4m
bmJzcDs8L3A+PHA+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGRldm1hcCA9IGRhc2RfZGV2
bWFwX2Zyb21fY2RldihjZGV2KTs8L3A+PHA+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGlm
IChJU19FUlIoZGV2bWFwKSk8L3A+PHA+LSZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtyZXR1cm4gKHZvaWQgKikgZGV2bWFwOzwvcD48cD4rJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO3JldHVy
biBFUlJfQ0FTVChkZXZtYXApOzwvcD48cD4mbmJzcDs8L3A+PHA+Jm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7IGRldmljZSA9IGRhc2RfYWxsb2NfZGV2aWNlKCk7PC9wPjxwPiZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyBpZiAoSVNfRVJSKGRldmljZSkpPC9wPjxwPi0tJm5ic3A7PC9wPjxw
PjIuMjUuMTwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF
6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2Zv
bnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxl
PSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVp
OyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF
6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

