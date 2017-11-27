Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] s390/virtio: add BSD license to virtio-ccw
References: <1511500846-24696-1-git-send-email-mst@redhat.com>
 <1511500846-24696-2-git-send-email-mst@redhat.com>
 <20171124140918.GF4284@osiris>
 <20171124181148-mutt-send-email-mst@kernel.org>
 <20171124165301.GH4284@osiris>
 <20171124190132-mutt-send-email-mst@kernel.org>
 <20171124171834.GA2857@osiris>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 27 Nov 2017 09:15:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171124171834.GA2857@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ee9ad214-db0e-002b-0d6e-dfb2142deaf5@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 11/24/2017 06:18 PM, Heiko Carstens wrote:
> On Fri, Nov 24, 2017 at 07:02:41PM +0200, Michael S. Tsirkin wrote:
>> On Fri, Nov 24, 2017 at 05:53:01PM +0100, Heiko Carstens wrote:
>>>>> Is there any reason to add the whole BSD 3 clause license text? I'd prefer
>>>>> if it would be just the simple new SPDX-License-Identifier above.
>>
>> I added  it for consistency with other virtio headers.
> 
> Well, one of the points of the SPDX tags is to avoid the countless
> duplication of license texts. Adding a license text is easy, removing it
> again later is not as easy. Therefore I would prefer to avoid the
> duplication here again.
> 
> Cornelia, Christian, any opinion here?

I would prefer to not have the full licence text and only have the SPDX string
if that is allowed by the licence.
