Return-Path: <linux-doc-owner@vger.kernel.org>
Subject: Re: [PATCH v2 31/79] docs: s390: convert docs to ReST and rename to
 *.rst
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 23 Apr 2019 12:12:41 -0400
MIME-Version: 1.0
In-Reply-To: <fb86b676b3b426732f1f11378868a9bd3b580b46.1555938376.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3b40a683-a77e-0219-b5bc-2ead38e627af@linux.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 04/22/2019 09:27 AM, Mauro Carvalho Chehab wrote:
> Convert all text files with s390 documentation to ReST format.
> 
> Tried to preserve as much as possible the original document
> format. Still, some of the files required some work in order
> for it to be visible on both plain text and after converted
> to html.
> 
> The conversion is actually:
>    - add blank lines and identation in order to identify paragraphs;
>    - fix tables markups;
>    - add some lists markups;
>    - mark literal blocks;
>    - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab<mchehab+samsung@kernel.org>
> ---

Hi Mauro,

How would the s390 rst files be accessed from a top level index.rst 
file? Is there a view of the changes? I looked at a link you posted [1] 
as a reply in another thread, but I couldn't find the s390 docs there.

[1] https://www.infradead.org/~mchehab/rst_conversion/

Thanks
Farhan
