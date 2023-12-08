Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJlS8vYp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B922D73
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 10:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702059214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thkLXVvi4ESeehaUbk7FHcY7MvVf7sRDiGhqTuUD1bw=;
	b=IJlS8vYpxtvx9lMjD17SnflauDwiG/V/XgrfwB8TSRHkfrpXqpdOnJzwx7AW4FsERM9xui
	hxJovqYCpLix/bDSozbcRKbSAHmMqLbYBuFZpJvmjJIEMktflMA+/YfR7bofnNaml6GMH3
	6/rSMmoPPL7Tzlj9dDURmBL6CXGG/Hw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-DQylUjy1NfSUcOVmHlyK5g-1; Fri, 08 Dec 2023 13:13:33 -0500
X-MC-Unique: DQylUjy1NfSUcOVmHlyK5g-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-589f2897a46so2657621eaf.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 10:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059212; x=1702664012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thkLXVvi4ESeehaUbk7FHcY7MvVf7sRDiGhqTuUD1bw=;
        b=DCZbsrBdn4LQxoW4mUwSxM1mgEtb+8fAt51M1B34C8lCb+0WzUOiYj8gAeVhkSiGCK
         ZzVFqJfSltFTmBeXSTgsdbuXq3Uw2ZaUHc2khLmC7xoCr56UREiwCVXzvnrFRFqfr05y
         tOH3H0W3JWUMIIpXQ4tCTmR6abXSlIRKRUMYSfiN2eSPS3hv+EXyxKe3XQQCz27rrdZl
         ANqUm/5KHxo+7jvpx2ahh79G6/47O8gV6H73DfFWRHtuhVIAEdHhfa8DsGtYq+3Gh0eT
         +X9idObXXm/NjScxMLnzmzNV8ly9YC1hC9pOaTzbcnv+LgkiX9gMHOP45sykA6PYtQIo
         iFgg==
X-Gm-Message-State: AOJu0YyZV+2kaJ8ZZ+UdOZVj1vjo242TtZqUM8XcDXKWB2MbBvZT2WsC
	uzmqYWzy7MSvdGAtUg4Hu+XEC1DUaEyOtghLU5YcToyr/rUD2y/Dl78n2yy66eq0kNoryDgQG+z
	/rVrJN4vH8KhG7l75GSeyvodxaJVRSDnKrbsPjuWO5oJs8w==
X-Received: by 2002:a05:6870:9d0e:b0:1fb:75a:6d3a with SMTP id pp14-20020a0568709d0e00b001fb075a6d3amr514102oab.97.1702059211861;
        Fri, 08 Dec 2023 10:13:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm4qEiQ8h/zEqW68UsgEFDDQ1CGBXnQu7hSfvylqpZk9GjGB2KlkuB5RxbvYYtZ8eZbfTt4oXKVMMdArXHtU0=
X-Received: by 2002:a05:6870:9d0e:b0:1fb:75a:6d3a with SMTP id
 pp14-20020a0568709d0e00b001fb075a6d3amr514096oab.97.1702059211668; Fri, 08
 Dec 2023 10:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115125111.28217-1-imbrenda@linux.ibm.com>
In-Reply-To: <20231115125111.28217-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Dec 2023 19:13:19 +0100
Message-ID: <CABgObfYt3VH-zPwT1whA0N7uE2ioq9GznTt-QhnES8B5tX76jQ@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/2] KVM: s390: two small but important fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, frankja@linux.ibm.com, borntraeger@de.ibm.com, 
	hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 1:51=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Hi Paolo,
>
> two small but important fixes, please pull :)

Done, thanks.

Paolo

>
> Claudio
>
>
>
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-6.7-1
>
> for you to fetch changes up to 27072b8e18a73ffeffb1c140939023915a35134b:
>
>   KVM: s390/mm: Properly reset no-dat (2023-11-14 18:56:46 +0100)
>
> ----------------------------------------------------------------
> Two small but important bugfixes.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (2):
>       KVM: s390: vsie: fix wrong VIR 37 when MSO is used
>       KVM: s390/mm: Properly reset no-dat
>
>  arch/s390/kvm/vsie.c   | 4 ----
>  arch/s390/mm/pgtable.c | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> --
> 2.41.0
>

