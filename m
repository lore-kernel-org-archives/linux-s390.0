Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 29 Apr 2019 15:59:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 04/10] s390/mm: force swiotlb for protected
 virtualization
In-Reply-To: <20190426192711.GA31463@infradead.org>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-5-pasic@linux.ibm.com>
        <20190426192711.GA31463@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190429155951.3175fef5.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 26 Apr 2019 12:27:11 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Apr 26, 2019 at 08:32:39PM +0200, Halil Pasic wrote:
> > +EXPORT_SYMBOL_GPL(set_memory_encrypted);
> 
> > +EXPORT_SYMBOL_GPL(set_memory_decrypted);
> 
> > +EXPORT_SYMBOL_GPL(sev_active);
> 
> Why do you export these?  I know x86 exports those as well, but
> it shoudn't be needed there either.
> 

I export these to be in line with the x86 implementation (which
is the original and seems to be the only one at the moment). I assumed
that 'exported or not' is kind of a part of the interface definition.
Honestly, I did not give it too much thought.

For x86 set_memory(en|de)crypted got exported by 95cf9264d5f3 "x86, drm,
fbdev: Do not specify encrypted memory for video mappings" (Tom
Lendacky, 2017-07-17). With CONFIG_FB_VGA16=m seems to be necessary for x84.

If the consensus is don't export: I won't. I'm fine one way or the other.
@Christian, what is your take on this?

Thank you very much!

Regards,
Halil
