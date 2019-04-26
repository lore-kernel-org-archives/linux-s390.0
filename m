Return-Path: <SRS0=JTmC=S4=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 26 Apr 2019 12:27:11 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 04/10] s390/mm: force swiotlb for protected virtualization
Message-ID: <20190426192711.GA31463@infradead.org>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-5-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426183245.37939-5-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 26, 2019 at 08:32:39PM +0200, Halil Pasic wrote:
> +EXPORT_SYMBOL_GPL(set_memory_encrypted);

> +EXPORT_SYMBOL_GPL(set_memory_decrypted);

> +EXPORT_SYMBOL_GPL(sev_active);

Why do you export these?  I know x86 exports those as well, but
it shoudn't be needed there either.
