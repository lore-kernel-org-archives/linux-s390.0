Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
 <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
 <20200415221754.GM2483@worktop.programming.kicks-ass.net>
 <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
 <20200416141547.29be5ea0@p-imbrenda>
 <de56aa8e-9035-4b68-33cb-15682d073e26@intel.com>
 <20200416165900.68bd4dba@p-imbrenda>
 <a6b8728d-7382-9316-412d-dd48b5e7c41a@intel.com>
 <20200416183431.7216e1d1@p-imbrenda>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <396a4ece-ec66-d023-2c7e-f09f84b358bc@intel.com>
Date: Thu, 16 Apr 2020 12:02:54 -0700
MIME-Version: 1.0
In-Reply-To: <20200416183431.7216e1d1@p-imbrenda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On 4/16/20 9:34 AM, Claudio Imbrenda wrote:
>> Ahh, so this is *just* intended to precede I/O done on the page, when
>> a non-host entity is touching the memory?
> yep

OK, so we've got to do an action that precedes *all* I/O to a page.
That's not too bad.

I still don't understand how this could work generally, though  There
are lots of places where I/O is done to a page without either going
through __test_set_page_writeback() or gup() with FOLL_PIN set.

sendfile() is probably the best example of this:

	fd = open("/normal/ext4/file", O_RDONLY);
	sendfile(socket_fd, fd, &off, count);

There's no gup in sight since the file doesn't have an address and it's
not being written to so there's no writeback.

How does sendfile work?
