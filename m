Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH 00/10] s390: virtio: support protected virtualization
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190503115511.17a1f6d1.cohuck@redhat.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <1eb4b501-b22a-bba6-d4f9-68a278f6bd64@suse.com>
Date: Fri, 3 May 2019 12:03:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190503115511.17a1f6d1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 03/05/2019 11:55, Cornelia Huck wrote:
> On Fri, 26 Apr 2019 20:32:35 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> Enhanced virtualization protection technology may require the use of
>> bounce buffers for I/O. While support for this was built into the virtio
>> core, virtio-ccw wasn't changed accordingly.
>>
>> Some background on technology (not part of this series) and the
>> terminology used.
>>
>> * Protected Virtualization (PV):

Uuh, you are aware that "PV" in virtualization environment is used as
"Para-Virtualization" (e.g. in Xen) today? I believe you are risking a
major mis-understanding here.


Juergen
