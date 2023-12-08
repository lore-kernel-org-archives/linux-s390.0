Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aec1e1ok"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CE1738
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702069378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnR71ERwB0xpUeMudALkEkT2aBnLdTFV83wSZKWUuyk=;
	b=Aec1e1okdM02CCFdcdf/QXgi2L86Y+BK4EBoitm+xghQ6wj0hjqR40CCOunqmrshQ9VNJ9
	K7YLYwz7+NlbpbZ4p4a8BKp2n3/ubjpig6kO8T/jvsiIM6RH/TukpIe/nupy5IJSK5fqHF
	VRyX0xW3F7943bwbmYHVQ+zxzU6pmnM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-QVGDSe_9MlmaVvRAzDlIoA-1; Fri, 08 Dec 2023 16:02:56 -0500
X-MC-Unique: QVGDSe_9MlmaVvRAzDlIoA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb2132b0edso4384221fac.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 13:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069375; x=1702674175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnR71ERwB0xpUeMudALkEkT2aBnLdTFV83wSZKWUuyk=;
        b=rTZ6QNQjulGFbhh2aazIctveSWFn5yRKMXEY7xEvFw0sTaxKvcQb6V+RxoQYJnus+N
         Nu6JoEWLbvccNKNv3+N5FLNoVmRJ4v3MwN7ls33uQErtqGeY7kjfM6C3d2/glykNSj1k
         qe4V1ne1yQA57HTZWioCDy+AuqxtoeEpzl4fGKhya9aPNRanYNoORLr/Da145tDV5O0o
         wa62OQ7OMAC+la/ZFsVAinbPqHAC8Z7qgsHWndCnK9IZxXOmwQbS8o55QFsKHX7kS8Mv
         oFKw5iR5u55gBujNsOA/Bb7HxfbLL2ZF1eozq970RmGoWqL36gjUM+Fuo4ALaN7RL4pN
         htRQ==
X-Gm-Message-State: AOJu0YwP2L5TNzIWdPrBN5gJsGu+hV4Ycqg9ibZIOyWo8H5og3V5VoGf
	UGUiaIGzzzcey/dQtMAL4FGg+Nqi+1Dm5tjkH/2WrGOD3vmT6Wk3HuN9rqa69EkQQUvaie2sMKz
	llMQ0Z8/WhgrIj7l0smLOV87WqgkCEVvNHy0dsA==
X-Received: by 2002:a05:6871:5812:b0:1fa:6f5:7b11 with SMTP id oj18-20020a056871581200b001fa06f57b11mr831745oac.36.1702069375681;
        Fri, 08 Dec 2023 13:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG70CYCSZWB6DKvr4hrnjBebC5sVpU0c4XwqZCNGpXXRnlou5CpzlriTsL34en/4bO5Edgmdws7P7mWyGAfy2s=
X-Received: by 2002:a05:6871:5812:b0:1fa:6f5:7b11 with SMTP id
 oj18-20020a056871581200b001fa06f57b11mr831732oac.36.1702069375461; Fri, 08
 Dec 2023 13:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115125111.28217-1-imbrenda@linux.ibm.com> <CABgObfYt3VH-zPwT1whA0N7uE2ioq9GznTt-QhnES8B5tX76jQ@mail.gmail.com>
In-Reply-To: <CABgObfYt3VH-zPwT1whA0N7uE2ioq9GznTt-QhnES8B5tX76jQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Dec 2023 22:02:43 +0100
Message-ID: <CABgObfYVfNsfjy36iBeq7qiV_m3smRKCyOSWQRV2E0OMH1bqAA@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/2] KVM: s390: two small but important fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, frankja@linux.ibm.com, borntraeger@de.ibm.com, 
	hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 7:13=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> >       KVM: s390/mm: Properly reset no-dat

A small question on this one, would it make sense to clear _all_
gmap-related bits, including _PGSTE_GPS_ZERO?

Paolo

