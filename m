Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500652C0303
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227163; cv=pass; b=CvPVlSKIBZ/mmCkOJrshMC6//H4xd2UjPFry+h7q+8a+VQe/uwyK4tsKXO622fLBP0xPMCoDxZQB48AYjKWzf8nZ7l++1otbDmwaeT4kS+5V2rWOmEdoyi2/8okB9I8uupzlqEF3k99zhG7YZC4farxuVs8V0SEaqK9zrhvMuoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227163; c=relaxed/simple;
	bh=E+tTTb2GqI1vaGquqP1jTXz6HThVzWgXkisHH8EuO8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAjSpJiV0P2lD0i5gpdqbXXZzebmH9cXiLHRD7/4AhMqHpfqxtlW+8dbw2KMd+C1x5I5+2Nx95vJP4RbApf83KuGXEXoSfvKM0Hco+0G0q75vMaxnNv/g/mqJSdoZp2IX7rRYCev+F/819HCL9wiLyN63FRQJOFFfCk9kseJx0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qH/zNhS6; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH/zNhS6"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bcda7765d64so995846666b.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779227160; cv=none;
        d=google.com; s=arc-20240605;
        b=J5s/y/gqZEu8+EqnqowBDxD42qTxhd3HqnWHV1bbOJbZgj5hWBuEgI4g5t5wD4GGgq
         tXKcmhVKcVGbct9r0SjjZszR25VLAZMV/Ymc9rA0AqWpxbqauzmZ3KEe3J/EKnAhWf6u
         mK8pyvYpUOoedrfXniSgQ+8F4ZAAY/NUtE5OT+T+m+/Ij9IDPrFry+nWe6vb1a3yC3QB
         tKkGPPOYbZYAxr3yC2BccS+C03X3cStAg2nqgUXrfm7ugG41X/8lwyAjBPUDDCG349Jl
         s5JW8/vQurDPpVK8EAv06bjTueM+lzowR0l4il1FXduGAjB0X3gm9vf7OVgwAGoqgF8n
         r6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        fh=vFvYU879jAaHr1oJFl2nNI//TpPfvd4f5RRPrzmEFS8=;
        b=k6YC4o9ypG2EMJqBzdnzsNv4x/rrtd/XHUrWIjPcKBdRmcDOyZOVi6UUSmA5k2sszc
         Wf0vaqA1voQBzFyEtZth8ypcfArJAaTNP2XrqMOQog23HnR0Owh19ZcfsICl0qeO7y30
         GQ596DuCvMkEmNs+3WfeSAWwPoX1N+ST4uqOmdSspuqFZuikGjAvTqvIYgehkwW8rd0c
         vkssdXe2f27G9ojfe4in9JoN4LsHNFDjvCCIhzLftWi5NZFGmsxKk6cW+GxCjdatfJiA
         Kv0qcOMrXuqhrUrvmUlkP7Mq/6bCaY1rKjkhsChfHRnnKuifcYFXf/oeNUnT3rwmaarO
         8p/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779227160; x=1779831960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        b=qH/zNhS6SIUfjxARuMltjUodOjqSlRYKcR0o+zLMBNogXSHqlZQEMROvOJeC4f+f2E
         vLiEwZ0KUkgNGb+zoOfElkOVC713+DtaP4WZV9waekz+vU46a7NoDVWILgMsoDCezKT8
         FSHAz7tLZ3pD2vhTmhUfY6KiKSKdQ4x9dvtDvX6LI85Q6P96xQCCBLJizkqXaw5OtLRj
         jdafE8d7/JlkF70wStQuo26FL+txH1Ro8Fgth/OhWw+uenQEwgf0lMncusjGt0qbig8u
         jOEMJttZd/ZNnsssN5mDfT7QEI1QsqUGrOKAcLYyGfZKDPRihUu1MlMA6ZmuGeSyMXkC
         Irnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227160; x=1779831960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgd9wE8Ebw9Qeq3ppb48yPpKAYw41QQCB9/zb11k+vo=;
        b=biZOPF5EKbGpWEjN1Q/9RBVEao6O8O6z1BUIrAqMDW/O2Hz+M4nFB1nMfMe3KD7l89
         StoIrBaTrReSKozOhrfHHeCWebbrRH2WBoB2bGKVUZ+i1J3zMRe0eYZDXvsrEW04kJJv
         abY5vbAf4x8XFQjKSnCcF6VXdAMnxCdjq4y/8/N2HUIB+Y6cQaEsvD4Rxo/6VIXt20+W
         D1QFYNsYc18vFLI86iq64bZXYMSBZys5I1hkE/IyJo/YvNxxl/nVKokK3jvJAcsWp3Yf
         ZsCHmqNYZ6lFluE3lWkecgbwXAGUWYhfHbE8Hnt20nb/kIcRs2HryvQx0ru6x89CNBxX
         0Fog==
X-Forwarded-Encrypted: i=1; AFNElJ8iHaPdE/k3EzG0YU39Y9o2Bj5sPHtSmuGCh+DS7xY62dxkP5RsZ0KDdBrfoY36UmftizcEyKGsSbY9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kBxx5khMFkWiCKHDxmZLIU6NGFDTv/qVxfpc5tvnKrMoeH7e
	bYWX+pZU52pDX78K9ZtaadKH8hWW/tpswuuRH7R00PXhISp6ThjBRBh3DM8noLMYyWNkZ4P2h5o
	4xvCpnI0h0FpzsRlD1TBekDSp4rcjoS0=
X-Gm-Gg: Acq92OFELEUxSJvwPL/AAiw02MroFj9vfa4xcenJZAou8xYuCjmko/bC1JfHOmeszEX
	3W7+D1eRaKLw/W1v8Rs5fSiMcBk9ABmXF9qNnfOwjgylpdFI86LFvYJc6loNS4A439wVa0MdfOa
	X0o8bUO8nifBUStpYlUbheuJ5ZQO2KmaO2vfkiKTayxh7PrfKneJKEPTdJk9w4unU/2LQ5iY9cL
	OVuTZsxuJGJfwE0MetyYsT7dmpBj0TEuG+kKe+HxvvU4hWdTLJ+k+S51C+mvqO3Y/terxdv+AHI
	tQjMCn8RTBWaasC1gAjQxeKDqplgElvquznwBra84dSxiJR101BtkJFNygO01gzC+CUHT+FZDin
	a2gCwrG9M3DFh2T8xU1ik55Ig/wIvdAeNQ8AZj8FegYgHVUAVL9KO+DmDot9bQE5oPB34
X-Received: by 2002:a17:907:c10:b0:bd1:f09f:f819 with SMTP id
 a640c23a62f3a-bd4f34bd039mr1176086066b.25.1779227159626; Tue, 19 May 2026
 14:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519005206.628071-1-rosenp@gmail.com> <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
In-Reply-To: <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 19 May 2026 14:45:47 -0700
X-Gm-Features: AVHnY4L2A3cissyWzUYO1tXUDK8qIVjkmnbUtyGij0zc_S6K7Z3Goo3Q7aTrmVA
Message-ID: <CAKxU2N8_JhZhsSqm15DxFBkXv=ZBYQXQJ7xdw6SHrwG9dsWZVg@mail.gmail.com>
Subject: Re: [PATCH] smc: Use flexible array for SMCD connections
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: linux-rdma@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:57=E2=80=AFAM Alexandra Winter <wintera@linux.ibm=
.com> wrote:
>
>
>
> On 19.05.26 02:52, Rosen Penev wrote:
> > Store the per-DMB connection pointers in the SMCD device allocation
> > instead of allocating a separate connection array.
> >
> > This keeps the connection table tied to the SMCD device lifetime and
> > simplifies the allocation and cleanup paths.
> >
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> I don't think GPT did a good job here.
> There are many other instances, where smcd->conn is freed,
> those would need adoption as well afaiu.
git grep kfree | grep \\\-\>conn\)
drivers/media/dvb-core/dvbdev.c: kfree(dvbdev->adapter->conn);
net/wireless/sme.c: kfree(wdev->conn);
net/wireless/sme.c: kfree(wdev->conn);

I assume you mean net/wireless/sme.c
>
> I am also not sure that there is enough improvement in the idea
> to warrant a patch, but I leave that to the SMC maintainers.
>
>
>
> >  include/net/smc.h |  2 +-
> >  net/smc/smc_ism.c | 10 ++--------
> >  2 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/smc.h b/include/net/smc.h
> > index bfdc4c41f019..a2bc3ab88075 100644
> > --- a/include/net/smc.h
> > +++ b/include/net/smc.h
> > @@ -40,7 +40,6 @@ struct smcd_dev {
> >       struct dibs_dev *dibs;
> >       struct list_head list;
> >       spinlock_t lock;
> > -     struct smc_connection **conn;
> >       struct list_head vlan;
> >       struct workqueue_struct *event_wq;
> >       u8 pnetid[SMC_MAX_PNETID_LEN];
> > @@ -50,6 +49,7 @@ struct smcd_dev {
> >       atomic_t lgr_cnt;
> >       wait_queue_head_t lgrs_deleted;
> >       u8 going_away : 1;
> > +     struct smc_connection *conn[];
> >  };
> >
> >  #define SMC_HS_CTRL_NAME_MAX 16
> > diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> > index e0dba2c7b6e3..bde938c5eb39 100644
> > --- a/net/smc/smc_ism.c
> > +++ b/net/smc/smc_ism.c
> > @@ -467,17 +467,14 @@ static struct smcd_dev *smcd_alloc_dev(const char=
 *name, int max_dmbs)
> >  {
> >       struct smcd_dev *smcd;
> >
> > -     smcd =3D kzalloc_obj(*smcd);
> > +     smcd =3D kzalloc_flex(*smcd, conn, max_dmbs);
> >       if (!smcd)
> >               return NULL;
> > -     smcd->conn =3D kzalloc_objs(struct smc_connection *, max_dmbs);
> > -     if (!smcd->conn)
> > -             goto free_smcd;
> >
> >       smcd->event_wq =3D alloc_ordered_workqueue("ism_evt_wq-%s)",
> >                                                WQ_MEM_RECLAIM, name);
> >       if (!smcd->event_wq)
> > -             goto free_conn;
> > +             goto free_smcd;
> >
> >       spin_lock_init(&smcd->lock);
> >       spin_lock_init(&smcd->lgr_lock);
> > @@ -486,8 +483,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *=
name, int max_dmbs)
> >       init_waitqueue_head(&smcd->lgrs_deleted);
> >       return smcd;
> >
> > -free_conn:
> > -     kfree(smcd->conn);
> >  free_smcd:
> >       kfree(smcd);
> >       return NULL;
> > @@ -557,7 +552,6 @@ static void smcd_unregister_dev(struct dibs_dev *di=
bs)
> >       list_del_init(&smcd->list);
> >       mutex_unlock(&smcd_dev_list.mutex);
> >       destroy_workqueue(smcd->event_wq);
> > -     kfree(smcd->conn);
> >       kfree(smcd);
> >  }
> >
>
