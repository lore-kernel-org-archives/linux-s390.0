Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8934DCFD
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633141; cv=pass; b=bbDfTC+q3VdeESlb17W65KEj3yYzQS81sp6OeFd95I56/t8zMY1mUGGpuD8N1lpyDPdYDoVJPfGC5SNRug19LEBuVcvTLaPRVR64ts5zMty74WW2MCCKtZIF7k5bCUr7M/7ML6FSnHLQy7xcfiezRLCe5ee2BPCDS7Ft4kbCP48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633141; c=relaxed/simple;
	bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2N1h9A3/Ta7DZtATX85n49Sk1AJd2TWbjm5KB8So0KvzxloAtztBhwGiw5NnxwORPhVrA7jips7m2hQgZfLLgqFwL0XfEVsXe5DG8mCxn0zq1kRxc6zTpWWPTFCUcmm0f6tmjbPnlnJxV/eHRMrmHsE/3tZnyc8IqtQh1fWB0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opSKs3BP; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opSKs3BP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b6c45781aso51851cf.0
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 10:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633139; cv=none;
        d=google.com; s=arc-20240605;
        b=ZPeaocOfg5jV8TRf8agMoMCp+cSjzhYsJITAj5BaSZH7rIEdbq2sD1lOpmngqv5NGF
         B53TwsyonHq9L9wGgUTiHLLk6xifr9f4r+csvvcbjC7nmX+GbpY5C4hjjVyVPuLBx7ad
         9QcpwOKEffaxKRGIv13TdYAuLPhp9tnjlFjskX4sqovgOh2zdJhLi4a2qufP1quf/ciU
         T3LWKUHvu0lXjHa1OgSzVLFgQrnb2GpMpISn2KdwsWfsano/51VQYhH0Ex17+PyQvMvr
         1S8Xdup/9v2kp6fZyk7N7i3itxbJ1FyCo/zWEtNEClIh8DCXQKrsYpRw3iEl74dbHWd7
         qClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        fh=WAu1vLbjDPp09qMaX9A4JimzkyqoekPOU48NGjsr5V8=;
        b=hFCWR19e+/j0npf4ra0LGerHQzilFyLs666tplTsQRJ0H7WpwJ7Q68HPQSnLVR8PKg
         v2AiZts/yROIl1+1eHVSTQbRZzpLPZJv4QO7PrV6iiHqCI/8AiY3hnvnyJe7vB6lMmAn
         3Qk9FQUxv3g9yRv/1W31t3mGrqEJSWmVFID5kMxdN+e5sUMsLwFgMtfhMrn+I7ceP5vy
         twarG3POWDI2r2Lxk2165kchFvk+7tchTE1ktXIAdLJt1hrAkjPxmOWFttDKD0T4i5+R
         SNg/E9tC1tbfTlW2VC5HnzokVY9mFFiPlbh3J0BC4Sz9R1okX+IRD+Bj1FJHRFkRYVVs
         +KqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774633139; x=1775237939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        b=opSKs3BPu7dSxGPm6JNfm+Omgl9uoKm/frGzekk0adgkPgGVFARjSNXYovVTKkOm68
         xTPjhA6zfYiENlv7JTzz+oJF9BEH0sNvBwLslwPpSHgXr+TtAHieg+CwQUxDWzmZhi0e
         HwBS/XGfdlQ3PG42XBy078btdTGuGKCdDJYVJPe9htGkUQfDagKyfOWHmDHg5RDC5eBu
         GVJy2EZ6xJYDrEWSRDCLFJqI6WqGbr1GgKfk/9BxJ5sM9sRtDbhC3P+b+snpFj2Fm9kk
         76o1sjVysDGw+g6xkm+4G+fhiaViWS6pdApI8Q9YPMc17FW151CPJXrNHlc0yvTzcA5g
         hRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633139; x=1775237939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        b=ejipPbHwkPl/Xhl2NxQ/wF/GwNLcw28o2GK2Kvp2RqoWUo0Irkzsbrp0H+tNy9RGhE
         CtETwTes6Amcci+VCHSTFOVjPWBlnOlsQpT5OFijysX+X7vEBzhIzP5JXRb+mhg0Mait
         WOujlOKzYg62mQBSR4bWqvifnos/+lrrNaLqUwSa4WqxoDqo0CTwYQbT76EcjQdIkTRw
         sjtjx37wINPQ5m58hQ7DPFCpkdugNN4o8DCjOVbKNg5/QBdW9q3QrdutdJPp1E+1kMIy
         rBgneH0XnCD4SMhlAPE7ym5BrLLU+dzuLl43pQkqA8TSyNAf3kZ3eruN7FoDw2D89dB0
         9qCw==
X-Forwarded-Encrypted: i=1; AJvYcCWoSULiHWJS65ak/DefnxYQ3KKGAkLX11SZ3AR6Lb2xtuTXyY7n5X26JLaYaHF8Rtavb9wriVNo+20p@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzZXeN9rjYSNoipx7IZFb5mPy82vCOyXyxwLrU/70BuAwCnjr
	HD81J7wNPdrD4kHk1FNtNAySIbm3MzdrOUoFswFYYPJPQORtYiJ9ugPzifcFWzV41tvEm7BpAlr
	DK8Tym14LHFnTwSaM+OGfcXSIaGFTWIl9kZCKwuVX
X-Gm-Gg: ATEYQzySyaCKcJX8BRV4yPUUzgt0OxqW+D1mJD7k82Hi+zaOJz1ULavr7y4Rgugwa/3
	j/TFCpIzHdNptECgs83726nakrHZZe9Y/zjXRCuVcn0lrmJ6V/YhlU5WFmEP1+/fMc0Zm1EUho3
	0PTBWr4eVvCyLr5RTonZkNI3Yx7UWD+HEmkLnNm15SJf7L3JJVI938zLDoVvaZPOyQ4ZdhvZ6pT
	3OC7IUb2zjhG8v50/MUfHmg9+mCf5IJ89YXkp3L6H909h//OQsfWETmtdEvg0X9GzcBBsvzM6vo
	/gjiCQptf6Zoqj24WvRFwMpPR5H4AWhUFpQv
X-Received: by 2002:ac8:614b:0:10b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50bb268ef28mr670671cf.2.1774633138943; Fri, 27 Mar 2026
 10:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com> <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
In-Reply-To: <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 10:38:47 -0700
X-Gm-Features: AQROBzDcdJIiYfqLEUVIyX_QE3l_JxzoPz7imokMkPm7FnH6uOW_OZAJgfsGn0o
Message-ID: <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:37=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> > >
> > > > Three of your patches lack review tags so now it's 65!
> > >
> > > Three is now zero, thanks Lorenzo.
> >
> > I just finished fixups for issues Sashiko flagged. They are pretty
> > small but important. Testing them right now and running Sashiko
> > locally. Once done I'll post v6 and will ask Lorenzo to re-review
> > those specific changes. Sorry Lorenzo, I'll point out the specific
> > changes I had to make and will try to make it easy for you.
>
> No worries :)
>
> Could you send to ljs@kernel.org on the respin? Sorry to nag about it but=
 my
> email more and more set up for that and makes my life a wee bit easier :>=
)

Absolutely. Thanks for the reminder.

>
> > Thanks,
> > Suren.
>
> Cheers, Lorenzo
