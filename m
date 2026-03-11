Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7432C3268;
	Wed, 11 Mar 2026 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257455; cv=none; b=q2hqPoEXxOPCV0zR/XCobba0RccyaNiaPMKhX1U571l4hA20QSjr3p1YgUWFOquQf63vJkYovxDCROqO5E2gW/RlGRkP+ihYSiM3xWiZlUK2EUptY0B0MTqsNzb1XmFwExfV9Xif14NypUpQIj3TvA49GNesd64IkdpG9kWLw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257455; c=relaxed/simple;
	bh=EZNqHa6WQnBZ6pOjtoBstxswfNkYTwbxOyxg806ujLg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qwraYidnakMBXr15tdNlg5ihrjPkoL24n4WEE9IH1/9SBNIJRQZWPKCUzB17b7+Es91WeQPIdWnL/mSRuXXaAxLrP/Y90SD9E+IcYBp4FEniKAeBMRS/oapySw7RXurANtTEi3OU5r1I+qH8ouOSuxlrbFz8zzv6uiq3PwD002M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ngoQcNu6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ngoQcNu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773257441; x=1773862241; i=markus.elfring@web.de;
	bh=hYDbd29Vea9+Jy6I2ptfX4ZGZUtZFW9zPPCgeHBEQk8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ngoQcNu6UkGMog750T1j8y3hD3FuPICQc2JAScquH1SKykk7X5gYGSl0vbJqomLj
	 y+78Une4I/FwtKjOVjvwvrsQXywq9wMWeX5hfcDJZaqmXq7+HOTTkioysYS6YxvEx
	 1rGMZ5HPvF7YUA1nLlYDqT+0AakeE6T+uOpsk03Ii7rUq1LCvxOmJoeijU9kOhiEq
	 gvRRQdtx7VVu12IjJg4QXCt3n5ptih8u6qNXGzvSjG7b+WLqYgbSYXVAGGG4HiToe
	 UnI877nmuPfI1rdI8bmjwYlBlmPV0X6ol0z2pJtt7ekS6Lx2ME6o7/vUasVWNbMBk
	 26GIfkT4+NkMyvQuNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1vymRX1zPW-00GmJl; Wed, 11
 Mar 2026 20:30:41 +0100
Message-ID: <9e31dbbd-561c-4352-84ea-3ee0c9aec567@web.de>
Date: Wed, 11 Mar 2026 20:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <20260302203325.3826-7-alifm@linux.ibm.com>
Subject: Re: [PATCH v10 6/9] s390/pci: Store PCI error information for
 passthrough devices
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260302203325.3826-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HPKmTBKcLbSwuehcyl35mi3tqincS8ywGcQViZXZ1LAC5m6aSpm
 rWngieCPsM6L+W0Uea/8jbUVMQJ21JRsb+9HS8EWX/rBUl0WALDp3Ecp0Qsv7rzaOnUhwY0
 rkdxD8xSSAMRaMrNLst8tk/+qclSNUgCB0tRc9Qoam22VEhP5wHXqhdMTeYrHpN/Id27BX+
 0a4AwVACrZP8djMCS15Fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:36IQHx8uFAc=;/cqlYud0MwhIb9GrdYKz579hdvS
 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

=E2=80=A6
> +++ b/arch/s390/pci/pci_event.c
=E2=80=A6
> +void zpci_cleanup_pending_errors(struct zpci_dev *zdev)
> +{
=E2=80=A6
> +	mutex_lock(&zdev->pending_errs_lock);
> +	pdev =3D pci_get_slot(zdev->zbus->bus, zdev->devfn);
=E2=80=A6
> +	pci_dev_put(pdev);
> +	mutex_unlock(&zdev->pending_errs_lock);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&zdev->pending_errs_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/mutex.h#L25=
3

Regards,
Markus
