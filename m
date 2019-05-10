Return-Path: <SRS0=etnf=TK=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 10 May 2019 09:49:29 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 04/10] s390/mm: force swiotlb for protected
 virtualization
In-Reply-To: <4c7a990a-7f11-17f3-2024-18acaf7ceb06@linux.ibm.com>
References: <20190426183245.37939-5-pasic@linux.ibm.com>
        <ad23f5e7-dc78-04af-c892-47bbc65134c6@linux.ibm.com>
        <4c7a990a-7f11-17f3-2024-18acaf7ceb06@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190510094929.67e4ad29@p-imbrenda.boeblingen.de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Cornelia Huck ," <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin ," <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, "Thomas Huth ," <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, "Vasily Gorbik ," <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 9 May 2019 14:05:20 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

[...]

> > +#define sme_me_mask    0ULL
> > +
> > +static inline bool sme_active(void) { return false; }
> > +extern bool sev_active(void);
> > +  
> 
> I noticed this patch always returns false for sme_active. Is it safe
> to assume that whatever fixups are required on x86 to deal with sme
> do not apply to s390?

yes, on x86 sev_active returns false if SEV is enabled. SME is for
host memory encryption. from arch/x86/mm/mem_encrypt.c:

bool sme_active(void)
{
        return sme_me_mask && !sev_enabled;
}

and it makes sense because you can't have both SME and SEV enabled on
the same kernel, because either you're running on bare metal (and then
you can have SME) __or__ you are running as a guest (and then you can
have SEV). The key difference is that DMA operations don't need
bounce buffers with SME, but they do with SEV.

I hope this clarifies your doubts :)

[...]
