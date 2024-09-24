Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997D1B85D6;
	Tue, 24 Sep 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194702; cv=none; b=UB5fUi4Q3kYRq1x77y+kv9U4thc5tfJQbUYCY+fS0VEWADRXozzMb3CvIKUTddAvapTfuGMeLd94iOqVw5vIl4NGkjH6QRucEVraAfVr0khQzbeNIt9YkXvFuTsb5l8qUfYrbqAxBpnvmko2FvgzQ3/uSQDwhSxvSJfeaZxxPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194702; c=relaxed/simple;
	bh=PT0lyLWCzDMg6e0IygWA/ME0OBNzsZloIN855opPfks=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZF6qPswznI+V0G9gHQKI6SllSNY2WGdYgxSpk2LmEv2r41dZfUXLh/cLeapWf4NLYrnAxV0+Ba2kbOQebyCHynbjvFrldCP6+pC1PymKJO1m6DXUxG3yJwximD847aeK5U8JUX01jhAgXbW+8VccN5wrTniO8UKtAEcJLT27F0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=q2M6gTvx; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="q2M6gTvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727194690; x=1727799490; i=markus.elfring@web.de;
	bh=ef1H5okpnW0lEveexTopGosOnwOLDCpTvbhsBXFDoPo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q2M6gTvxITcDmRxd7UG1Ym9WqeMC42JZrCamYcv0S1rP6InEhKDFISUxwhU8H/Zf
	 KlMOvXxuF5je+DTQkVH0Zl2PFO5Hisgyql7VkTk9rj5brnpfwAJh6Td67xrW8dcTJ
	 VZoW6xSgYi9LIWLTwfCWNbYg9kdhHBVwhIOezTcyKoQqi4jQ/KSS7CLObUP3rNw5f
	 Pkd7jU6CUX3Kkoz7+fbjuLFEkDtXpKREkxTG4eqIQleZGYl9beaqIkozfuz/ldOzf
	 Kwg9f/JUdzs4bJRcce2llUh+dAGMaZcsFuGm0aICkn7JARhPW+EX5zzihQUG5lfWR
	 YFLkSX1mB/rN0YSM8g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKxV-1sHLaM3S9L-00f75B; Tue, 24
 Sep 2024 18:18:09 +0200
Message-ID: <e549c508-b3a2-4cba-b5ec-1a113286981c@web.de>
Date: Tue, 24 Sep 2024 18:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>,
 Ingo Franzki <ifranzki@linux.ibm.com>, Jules Irenge <jbi.octave@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] s390/pkey: Use common error handling code in
 pkey_ioctl_kblob2protk3()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9V2NY01eZ6b4e5LqzatdtR82eOcCFSV8v2LsfcIyRcNRDocfnz
 uaEvDaZbck9c24GSHLEUHrlTFogCuS6uo+oXoEJmoi2Tp86x0G1IloBJu6hDpzIsfHYlwPB
 VfqW8LhpxG4FDL+8yNTPW/cX1Satf6A1Gnf0PhVra6S1KhbOrye5P3TLyVnxaMfKWNgqlql
 XFJnGOZU1YuGIRSEfA8VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cmVKnXCKAxU=;9DDYlYrgOp0KuzBLnmUU9MTYX+j
 xcFYwSTGjkGYmCAvDKlvmCXVTCKJlWt/PInZ73bFs8ihnCT4GOnPDpaUEv2Q7cqg/4We0lXnh
 t/V3Mg4rA1j+8YQiYgxYPAUSVWgPubu3ytOWSTvnM/3Tu46/if6zGag5uuRqbOte/Qh/vR7SW
 9c3sXYTvkaSTDlvsmgZW49Y54Ll0rHWjExtEXhpVa+v0rdxKz/pcT+Ggu1oBG7/ZqFqQu36B5
 YWcAKvOYRpjT1D91GnwXoORvqHnkHzyp/6yrnPq007CA0el4FWw+hxSVpNqdOq9+CNyDQMftv
 QsNKQN1Ku6VML0rqULQGiZspmr+sNl0YgW5XFhoM4nHcQPhkqM5yEpFxb+CE/TBp8hJX3hlxa
 sm6iduXpLP+Io3is5bsej2atvKVQZxVArrlyCIAlmN/HkurRoIbmZAo972QW6AKojYoRnYcg7
 /+nbAetOCtEcoF6snzS7nAwBzZMuQyiTPxqhuSea08VeIJlX7GLkkVCIzZfeNCLvddVeYZuLU
 hlupVE1Aima2HsA5AdiBVtyiI8xQW7ftvTupq5TbDinR6H5SP0YpXEDg6GsldKNRUFacqCBTi
 dETGifs/mGaVKaxdEG6b7DeCWdBIEeSU1WwiQzvhA53nlaSFp3S6+dLn/E/PfN66GSAXTkjFO
 SSZ+Bxl1qQjiiKsRB54P+W+YCpkNVRJo4XlwgeccTXIK7+oEg+On1Cmy1Xi3a9EERU5YactoY
 kijGR3ME7m9eqrIHRofgQuRvQdprkfGH+NzLA0C8byM9dphqrPILJkzjHq7T0JMD5/m26edh8
 ibvokzNBOJBY3XKQeZNMyfYg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Sep 2024 18:04:56 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/s390/crypto/pkey_api.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api=
.c
index c20251e00cf9..78be7a633bf1 100644
=2D-- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -668,32 +668,31 @@ static int pkey_ioctl_kblob2protk3(struct pkey_kblob=
2pkey3 __user *utp)
 		return PTR_ERR(apqns);
 	kkey =3D _copy_key_from_user(ktp.key, ktp.keylen);
 	if (IS_ERR(kkey)) {
-		kfree(apqns);
-		return PTR_ERR(kkey);
+		rc =3D PTR_ERR(kkey);
+		goto free_apqns;
 	}
 	protkey =3D kmalloc(protkeylen, GFP_KERNEL);
 	if (!protkey) {
-		kfree(apqns);
 		kfree_sensitive(kkey);
-		return -ENOMEM;
+		rc =3D -ENOMEM;
+		goto free_apqns;
 	}
 	rc =3D key2protkey(apqns, ktp.apqn_entries, kkey, ktp.keylen,
 			 protkey, &protkeylen, &ktp.pkeytype);
 	pr_debug("key2protkey()=3D%d\n", rc);
 	kfree(apqns);
 	kfree_sensitive(kkey);
-	if (rc) {
-		kfree_sensitive(protkey);
-		return rc;
-	}
+	if (rc)
+		goto free_protkey;
+
 	if (ktp.pkey && ktp.pkeylen) {
 		if (protkeylen > ktp.pkeylen) {
-			kfree_sensitive(protkey);
-			return -EINVAL;
+			rc =3D -EINVAL;
+			goto free_protkey;
 		}
 		if (copy_to_user(ktp.pkey, protkey, protkeylen)) {
-			kfree_sensitive(protkey);
-			return -EFAULT;
+			rc =3D -EFAULT;
+			goto free_protkey;
 		}
 	}
 	kfree_sensitive(protkey);
@@ -702,6 +701,14 @@ static int pkey_ioctl_kblob2protk3(struct pkey_kblob2=
pkey3 __user *utp)
 		return -EFAULT;

 	return 0;
+
+free_apqns:
+	kfree(apqns);
+	return rc;
+
+free_protkey:
+	kfree_sensitive(protkey);
+	return rc;
 }

 static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
=2D-
2.46.1

