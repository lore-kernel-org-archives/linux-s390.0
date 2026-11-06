Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944950;
	b=BQ7emHxUivV/c+LPFHebiSpRyjbDKS7Bmi5WhL0/gybct/SaQoPP5pTU98WhNXk0PZby
	 4TIgr0MnOizgPSwN3mh0wzCmDT40wfdWuL0P3SZQmlYimK7f3FKl254AivE2B4cNwHxbJ
	 GerLzt8MqVJrQyM4Q6KQ+y618JyT1oSiLULVjyG3PqAgRDKMMc4EBqcyKKnz+uI3IvctV
	 d1n426j4ELfG3MpIYpp+649YUklkwPY4KvN6+yNOuQWxaRPYb2iZQC8M27fiUhSL8Sf6E
	 hIua1B5Ezbnj4Ww3QIbBueQwYgNbJB4vUiNEOFmtRNhjJZVR3OqIZw/yePQzifurrbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
	b=nRpO+zyAsR8HA6ilAft9za/N4btmgpq9Pi7uF3CrUFcNmLVNMUk+nVhibtIkED4pCF4q
	 k2HR+zaQw7E7n0MAN7qIR2xB8ivWGTEadSWbVuY1orVVeCLyiSGV0AP95TKv+CPppfGkA
	 60E5F3MfuGTscUePydWbgtE833v98qLh8yMOv8QH7idVl44AWpFSCVg62Q3A1D7cPo/5B
	 3Uxp0zHsUqcWRb46lbD4UgmzoLPoqS9O3uPuGNCxDLn8S92Omx7Zb0rJYYDfqc/1QhuzQ
	 Tdc7COrx1kHk6NCEZHI7ItoB3yMSlPykvVi3BiWDitvfoMoYW1r4BKqIKJH0ifpg0ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MU217h2+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFA606A328
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 06:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EADFA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MU217h2+
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c45551fa84eso41546966b.3
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 22:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793944948; cv=none;
        d=google.com; s=arc-20260327;
        b=N2dmW6zdobr5NO2JmmfHoYNIiKtNWVjyr7l9SJMT5MVP8Q55lnFAX9rlikdPKBXvU0
         d9S2Ko4JhqWTTBdN880bkNrgaR0SW1G4Cz/etxADJMRVKg+3oMo/swIw035Pb+cwXZuW
         dNKOAiYORnYQ5OFjYoulOGUGrdenkz/g56zd/uMzCD96zDtVzEu6iJ2/1ofzTso6H1wD
         +RqxJbQIsQd4HdKiuTBo5+RKMQXMXU46HtPWuRxw5WbLtlSZ4TvTl41CuojLeMbIRm/Z
         /WEcOOPPttrPgfrq2mJoDMa5ga1iagu0oQRCqwH/HtCIXAGXsmn+4ZYG4AnR/5QfI9ax
         GkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        fh=Uznc2Y+elTY4ZKH0PSjsoUPwmKTh2BD7h52EAFKfAaQ=;
        b=OpkDuzgYVH2fuKrihe3yFuziehcyiK928W+a3NGzOv5HADrU8IECACG9SqXZREJ58R
         HVrKin9nj6XUWv/YfWZB4ixDl/LgPUhoD7IxkDbznZspnvWM272eMvHMzcYzGFiNhqz9
         TGVWcGg3hfL5vP8eGLtHOl0NLG2WiFl3UhSXg8dqzWu5dTd+Qwam9rCjJ5gZl4bzhaQ5
         ixcHL6YzIg/ZgRqSxNmmusQ9jwkmsIQKDglEr0rvcaOFI3pBEyaLtbj5rUcddVAYDUyq
         sn/RXcKB3Cx6fikD9KDD7fpHKkRBnVI4CPjn/TctmyE1UtoMl5u/azoa4G3AZuUnMB2E
         qgTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793944948; x=1794549748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        b=MU217h2+0eERrqYba0rrf3WXQN92LuCzTp6j7sdlJu+GYLO/kCkie1ZHHu9k9lrgZp
         CKKnTMQfLQs5kiyXAfxCxwfvnBZXPVAFqPHSxoGpdKUE3ZOt0kpMnXkBn/uaf+FwTTu0
         BG5QSdusCxDz45pvQAkbgGTw7ondU7W7b9OxYbF1ZXSWe9yP4urk/zgYauxOQ5upl0IN
         a7cxcQJNl9iPjiPPJwL8T2v2nDl/Iug8czBx2fOKeMNd3OsUUK5jDN9v7UarVZvUjxoN
         wSBPLDyG8antoD6ihod1LeQD0yK97xnwSDBWzaCLiEbaH6U0MRXfIsBF2jEr7T/Y2npW
         cp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793944948; x=1794549748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upxm4MPlU7N3NfgqAJOH0IPRX5g3aVwXiEtIrdH4MTo=;
        b=x4Ihm+2AMCb9nKftivwkaqZt4TgVpq5s+oAQU7gEi8TQtSNeQpnFGpX/GzvWs4r/lk
         tL/DNVzk8qXXNSYCxt4bdGH09N0PCjc94UletggR97ikLsode4TY0gufw7jQfxKz4wUe
         506wp+kKFrgpfeXP6d15eO02q4n7yN3mK2Yp6hi1G81cI8CwInJhyWrXqT4wQxhSqd4l
         z4BS34fZNVc0BOzwO2MuSuxn8z300OYJD0Sm+xm4r/idtFKpdxoTpj89SZaNDz0wxp88
         dWYVjqRp+8odftNRiL+J4+USp8aK87wzgN62JdiGKkIEtK3OXUyfp//nrXwOCcmp04bB
         XS8g==
X-Forwarded-Encrypted: i=1; AKwUvBxCLyBwMX/oxHaykelvHoiFLHRP4LgxKlxJ0nFHZe9tujzpCKoKcEFMM1uI4qYtO0A/9ozLJrrwt1AI@vger.kernel.org
X-Gm-Message-State: APuU4Z9Dw5xOT3L25h448kFxqBkA/tBxsFcOidvq8AOuriczSTfMrf54
	DDYM+WFdRJAEuLaxOx/MXeRYcjDu46MEYNpDUAyzwCPOcdlq7VikJAX9LHKHIZ10/Sk5tsGv71q
	bHzEWs2coh+gB9R90g/Tgo1LVrD8otFI=
X-Gm-Gg: AYBFou2zQBp7wLUNUzvNw02RLIiY9dm2RM+ImHYBoNfowPDQpDH+ruFGZFk7jfHQNif
	JrXauDcMUACsmOs6J2rCm8EpNeeFvMrTGGU43ngpvf5dLMxGlGZ0FCDq6rwiaUyBAw8SJvxQPFo
	yNP1nxCvLwZRXZHGd4Qc0pHlD8AajsgBKcQFVe+IMB7XfQna/9HuExQgTrHhJSqjZPcTl3vGcrR
	KWXfU/KQF/u0wp+PapM2sCnaV6h96nNsupuFJ9w+WsRiPF029Vc+SmPuEyiwQgG/hAGtN3hLx4p
	OTXIwEWi629/PdMDrLDarlId4eFpXri1yzwf/bvPBk+6+228VB0OdQHvHx2uVR8P9bPVOW3CnFt
	GM8URXeRHz3zcRufzWdAUh95976WtH0I1sg1ZrrZDYuqlVpKkvi9Y6CnSu7QDsbpZQynC
X-Received: by 2002:a17:907:7b9e:b0:c42:4750:8d33 with SMTP id
 a640c23a62f3a-c4d355354efmr132932866b.28.1793944948293; Thu, 05 Nov 2026
 22:02:28 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105193426.2999631-1-stjepan.poljak@gmail.com> <20261105144316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261105144316-mutt-send-email-mst@kernel.org>
From: Stjepan Poljak <stjepan.poljak@gmail.com>
Date: Fri, 6 Nov 2026 07:02:16 +0100
X-Gm-Features: AclHuK-YNzSXRW1RHjomN8YIUKv427RnMYB6bCZCxyhE73XOJIrYBtMyz-mjos8
Message-ID: <CAKVkeTxfwL9vFx_AFgevsQ1Kg0=DE9aSPYTcw8ZuyejhE+w7ng@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: return an error pointer from vring_create_virtqueue()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexander Graf <graf@amazon.com>, virtualization@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> not how you ae supposed to attribute LLM use.
>

Sorry about that. I've sent the v2 with corrected LLM disclosure as
"Assisted-by": https://lore.kernel.org/virtualization/20261106055635.301988=
9-1-stjepan.poljak@gmail.com/T/#u

Thank you,
Stjepan Poljak
